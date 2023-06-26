PROJID=$(cat /ccs/home/$(whoami)/.projectid)

module load cuda/11.1.1 gcc/10.2.0 git openblas cmake
module list

CONDA_HOME=/gpfs/alpine/$PROJID/scratch/$(whoami)/miniconda3
NCCL_HOME=/gpfs/alpine/$PROJID/scratch/$(whoami)/nccl/build
CUDNN_HOME=/gpfs/alpine/$PROJID/scratch/$(whoami)/cuda/targets/ppc64le-linux

export LD_LIBRARY_PATH=$CONDA_HOME/lib:$LD_LIBRARY_PATH
export PATH=$CONDA_HOME/bin:$PATH
export CPATH=$CONDA_HOME/include:$CPATH

export LD_LIBRARY_PATH=$CUDNN_HOME/lib:$LD_LIBRARY_PATH
export CPATH=$CUDNN_HOME/include:$CPATH

export LD_LIBRARY_PATH=$NCCL_HOME/lib:$LD_LIBRARY_PATH
export CPATH=$NCCL_HOME/include:$CPATH

# pytorch source-build stuff. Ignore unless you're building torch yourself
CUDNN_LIB_DIR=$CUDNN_HOME/lib
CUDNN_INCLUDE_DIR=$CUDNN_HOME/include
CUDNN_LIBRARY=$CUDNN_HOME
USE_CUDNN=1
NCCL_ROOT=$NCCL_HOME
USE_SYSTEM_NCCL=1
USE_DISTRIBUTED=1
USE_NCCL=1
NCCL_LIBRARIES=$NCCL_HOME/lib
NCCL_INCLUDE_DIRS=$NCCL_HOME/include
