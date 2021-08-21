#!/bin/bash

#SBATCH --job-name=HPL_AUTOTUNER-ID1
#SBATCH --output=out-slurm-autotuner.%j.out
#SBATCH --error=err-slurm-autotuner.%j.err
#SBATCH --ntasks-per-node=2
#SBATCH --nodes=2
#SBATCH --cpus-per-task=8

. set_enviormental_flag.sh
#. /root/.if-you-look-you-cheat/load-intel.sh
export MPI_PROC_NUM=4
export MPI_PER_NODE=2
export OMP_NUM_THREADS=8
export HPL_EXE=xhpl_intel64_dynamic

cp -f HPL.dat /shared/intel/oneapi/mkl/latest/benchmarks/mp_linpack/HPL.dat
cd /shared/intel/oneapi/mkl/latest/benchmarks/mp_linpack
#salloc -N 2 --cpus-per-task=8 --ntasks=4 --ntasks-per-node=2
#srun --cpu-bind=verbose,ldoms --mem-bind=verbose,local --nodes=2 --ntasks-per-node=2 --cpus-per-task=8 ./runme_intel64_prv
I_MPI_HYDRA_BOOTSTRAP=ssh mpirun -print-rank-map -bind-to numa -membind firsttouch -np 4 -ppn 2 -hosts compute-1-1,compute-1-2 ./runme_intel64_prv
