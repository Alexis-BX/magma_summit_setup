module load cuda/11.0.3 gcc/10.2.0 git
module list

CONDA_HOME=/ccs/home/$(whoami)/scratch/miniconda3
NCCL_HOME=/ccs/home/$(whoami)/scratch/nccl/build
CUDNN_HOME=/ccs/home/$(whoami)/scratch/cudnn-linux-ppc64le-8.7.0.84_cuda11-archive

export LD_LIBRARY_PATH=$CONDA_HOME/lib:$LD_LIBRARY_PATH
export PATH=$CONDA_HOME/bin:$PATH
export CPATH=$CONDA_HOME/include:$CPATH

export LD_LIBRARY_PATH=$CUDNN_HOME/lib:$LD_LIBRARY_PATH
export CPATH=$CUDNN_HOME/include:$CPATH

export LD_LIBRARY_PATH=$NCCL_HOME/lib:$LD_LIBRARY_PATH
export CPATH=$NCCL_HOME/include:$CPATH
