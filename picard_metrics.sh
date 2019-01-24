### bedtools coverage
#!/bin/sh
#$ -S /bin/sh
#$ -M yding2@illumina.com
#$ -N picard
#$ -m es
#$ -e picard.err
#$ -o picard.out
#$ -cwd
#$ -pe threaded 20

picard_dir=/illumina/thirdparty/picard-tools

sse_dir=/basespace/yding2/Projects/BGI_201811_SSE/AppResults

hg38=/genomes/Homo_sapiens/NCBI/GRCh38Decoy/Sequence/WholeGenomeFasta/genome.fa

bams_dir=('/Pedigree' '/Pedigree\ \(2\)' 'Pedigree\ \(3\)' 'Pedigree\ \(4\)')

n=0
for i in "${bams_dir[@]}"
do
	bam_file=${sse_dir}${i}/Files/*.bam
	n=$(($n + 1))
	java -jar $picard_dir/picard-2.8.2.jar CollectSequencingArtifactMetrics \
     	I=$bam_file \
     	O=artifact_metrics${n}.txt \
     	R=$hg38
     	
     java -jar $picard_dir/picard-2.8.2.jar CollectOxoGMetrics \
      	I=$bam_file \
      	O=oxoG_metrics${n}.txt \
      	R=$hg38
done

