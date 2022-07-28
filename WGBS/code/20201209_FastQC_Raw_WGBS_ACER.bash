#!/bin/bash
#SBATCH --qos pq_jeirinlo
#SBATCH --account=iacc_jeirinlo
#SBATCH --partition centos7_IB_44C_512G
# Number of nodes
#SBATCH -N 1
# Number of tasks
#SBATCH -n 16
#SBATCH --output=log_dedup

##########################################################
# Setup envrionmental variable. 
##########################################################
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
. $MODULESHOME/../global/profile.modules
module load java/jdk1.7.0_75 
module load fastqc-0.11.7-gcc-8.2.0-gia624n 
module load miniconda3-4.5.11-gcc-8.2.0-oqs2mbg
pwd; hostname; date
 
echo "Running program on $SLURM_CPUS_ON_NODE CPU cores"

##########################################################

reads_dir="/scratch/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/raw_reads"

find ${reads_dir}*.fastq.gz \
| xargs basename -s .fastq.gz | xargs -I{} \
fastqc \
--outdir /scratch/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/FastQC_raw

# Generate multiqc report
source activate my_anaconda

multiqc /scratch/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/FastQC_raw

 
