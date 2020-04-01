configfile:"config.yaml"
import os
import yaml

rule all:
    input:
#        config["samples"]
	    "out.log"

rule cutadapt:
    input:
        expand("{sample}.fq",sample=config["samples"])
    output:
        "out.fq"
    shell:
        "cutadapt -a {config[adapter][adapter1]} -a {config[adapter][adapter2]} -g {config[adapter][adapter3]} -g {config[adapter][adapter4]} -n 2 {input[0]} > {output[0]}"


rule fastqtofasta:
    input:
        rules.cutadapt.output[0]
    output:
        "out.fa"
    shell:
        """awk '{{if(NR%4 == 1){{print ">" NR}}}}{{if(NR%4 == 2){{print}}}}' {input[0]} > {output[0]}"""
        
#	"""awk '{{if(NR%4 == 1){{print ">" substr($0, 2)}}}}{{if(NR%4 == 2){{print}}}}' {input[0]} > {output[0]}"""
#	    """awk '{{if(NR%4 == 1){{print ">" NR}}}}{{if(NR%4 == 2){{print}}}}' {input[0]} > {output[0]}"""
#    run:    
#        os.system("awk '{if(NR%4 == 1){print ">" substr($0, 2)}}{if(NR%4 == 2){print}}' {input[0]} > {output[0]}") 

#rule bowtie:
#    input:
#        rules.fastqtofasta.output[0]
#    output:
#        config["samples"]
#    shell:
#        "bowtie-build -f {input[0]} {output[0]}"

rule mapping:
    input:
        rules.fastqtofasta.output[0],
        expand("{sample}.fa",sample=config["fasta"])
    output:
        "out.log"
    run:
        import sys
        from Bio.Seq import Seq
        sgrnas = {}
        with open(input[1]) as f:
            for line in f:
                if not line.startswith('>'):
                    sgrnas[line.strip('\n')]=0
 
        with open(input[0]) as f:
            for i,line in enumerate(f):
                if line.startswith('>'):
                    continue
                seq = line.strip('\n')
                l = len(seq)
                if l == 20 and seq in sgrnas:
                    sgrnas[seq] += 1
                    continue
                elif l == 20 and str(Seq(seq).reverse_complement()) in sgrnas:
                    sgrnas[str(Seq(seq).reverse_complement())] += 1
                elif l < 20:
                    continue
                elif l > 20:    
                    for j in range(l-19):
                        if seq[j:j+20] in sgrnas:
                            sgrnas[seq[j:j+20]] += 1
                            break
        savestdout = sys.stdout
        f = open(output[0],'w')
        sys.stdout = f
        for key in sgrnas:
            print(key + '\t' + str(sgrnas[key]))
        sys.stdout = savestdout
        sys.stdout.close()




