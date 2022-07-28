#PBS -k oe     #keep output and error
#PBS -m abe 	#mail me when job : a – abort, b - begins, e - ends
#PBS -M julietmwong@gmail.com
#PBS -N trim_galore_JRC_2
#PBS -l nodes=1:ppn=2,vmem=15gb,walltime=12:00:00 

#Set up environment
module load java/1.8.0_131
module load fastqc/0.11.5
module load cutadapt/intel/1.9.1
module load trimgalore/0.4.5

# Run TrimGalore using default adapter identification

reads_dir="/N/dc2/scratch/wongju/JRC_trim_JW/Raw_sequences"

find ${reads_dir}*_R1_001.fastq.gz | \
xargs basename -s _R1_001.fastq.gz | \
xargs -I{} trim_galore \
--cores 8 \
--output_dir .../Trimmed_reads \
--paired \
--fastqc_args \
"--outdir .../FastQC \
--threads 18" \
--clip_R1 10 \
--clip_R2 10 \
--three_prime_clip_R1 10 \
--three_prime_clip_R2 10 \
${reads_dir}{}_R1_001.fastq.gz \
${reads_dir}{}_R2_001.fastq.gz 






