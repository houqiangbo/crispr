（1）解压连接 pear -f CN20567_BKDL190816311-1a_1.fq -r CN20567_BKDL190816311-1a_2.fq -o CN20567_BKDL190816311-1a

（2）fastq_to_fasta -i CN20567_BKDL190816311.assembled.fastq -o CN20567_BKDL190816311.fasta

 (3) bowtie-build -f CN20567_BKDL190816311.fasta CN20567 -t

 (4)待检测序列改为fasta格式
 (5) bowtie -f -v 1 CN20567 CN20567_genome_sgRNA.fa > CN20567_genome_sgRNA.log(直接提取)
（6）从 CN20567_genome_sgRNA.log提取原先信息与reads写入.out文件
 (7) 报告填写，Total Sequencing Reads 为CN20567_BKDL190816311.fasta行数除2，sgRNA  Sequencing Reads为log文件倒数第2列之和，均一性
（8）用.out文件get_plot.py绘图
(9) .out文件转为excel文件

备注：
           GG结尾的需要去掉NGG(3个碱基)