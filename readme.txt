��1����ѹ���� pear -f CN20567_BKDL190816311-1a_1.fq -r CN20567_BKDL190816311-1a_2.fq -o CN20567_BKDL190816311-1a

��2��fastq_to_fasta -i CN20567_BKDL190816311.assembled.fastq -o CN20567_BKDL190816311.fasta

 (3) bowtie-build -f CN20567_BKDL190816311.fasta CN20567 -t

 (4)��������и�Ϊfasta��ʽ
 (5) bowtie -f -v 1 CN20567 CN20567_genome_sgRNA.fa > CN20567_genome_sgRNA.log(ֱ����ȡ)
��6���� CN20567_genome_sgRNA.log��ȡԭ����Ϣ��readsд��.out�ļ�
 (7) ������д��Total Sequencing Reads ΪCN20567_BKDL190816311.fasta������2��sgRNA  Sequencing ReadsΪlog�ļ�������2��֮�ͣ���һ��
��8����.out�ļ�get_plot.py��ͼ
(9) .out�ļ�תΪexcel�ļ�

��ע��
           GG��β����Ҫȥ��NGG(3�����)