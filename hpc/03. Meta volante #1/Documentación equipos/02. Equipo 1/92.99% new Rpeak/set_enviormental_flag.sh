#!/bin/bash


export CC=mpicc CXX=mppicpc FC=mpiifort F90=mpiifort F77=mpiifort MPIF90=mpiifort
# FOR UCX:
export UCX_UNIFIED_MODE=1
export UCX_NET_DEVICES="mlx4_0:1"

# FOR OPENMPI:
export OMPI_MCA_pml=ucx
export OMPI_MCA_osc=ucx
export OMPI_MCA_btl="^vader,tcp,openib,uct"

# FOR INTEL MPI:
. /shared/intel/oneapi/setvars.sh
export I_MPI_PMI_LIBRARY=/opt/slurm/lib/libpmi2.so
export I_MPI_CC=icc
export I_MPI_PMI_LIBRARY=/opt/slurm/20.02.6/lib/libpmi2.so
export SLURM_PMI_KVS_NO_DUP_KEYS=1
export SLURM_MPI_TYPE=pmi2
export I_MPI_CC=icc
export I_MPI_FABRICS=shm:ofi
# export I_MPI_STATS=1-20
# export I_MPI_STATS_FILE=/shared/configuraciones-HPC-cristian
export I_MPI_PERHOST=4
# export I_MPI_COLL_INTRANODE_SHM_THRESHOLD=?
export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=0
export I_MPI_PIN_PROCESSOR_LIST=allcores
export I_MPI_HYDRA_HOSTS_GROUP=compute-1-[1-2]
export I_MPI_HYDRA_BOOTSTRAP=slurm
# export I_MPI_HYDRA_PMI_CONNECT
# export I_MPI_ADJUST_ALLGATHER="1:0-524288;3"
# export I_MPI_ADJUST_ALLGATHERV="1: 0-524288;3"
# export I_MPI_ADJUST_REDUCE="2:0-2048;5"
# export I_MPI_ADJUST_ALLREDUCE="1:0-2048;2"
# export I_MPI_ADJUST_BCAST="1:1-12288"

# FOR MKL
export MKL_VERBOSE=0

#NUMA
export KMP_AFFINITY="verbose,granularity=fine,compact"
export I_MPI_PIN_DOMAIN="numa"
export I_MPI_PIN_ORDER="compact"

# INTEL HPL
export MPI_PROC_NUM=4
export MPI_PER_NODE=2
export OUT=xhpl_intel64_dynamic_outputs.txt
export HPL_EXE=xhpl
