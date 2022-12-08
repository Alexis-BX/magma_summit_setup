cd /ccs/home/$(whoami)
mkdir scratch

cd /ccs/home/$(whoami)/scratch

module load cuda/11.0.3 gcc/10.2.0 git

# install cudnn
cd /ccs/home/$(whoami)/scratch
cp /gpfs/alpine/csc499/proj-shared/cudnn-linux-ppc64le-8.7.0.84_cuda11-archive.tar.xz $PWD
tar -xvf cudnn-linux-ppc64le-8.7.0.84_cuda11-archive.tar.xz
rm cudnn-linux-ppc64le-8.7.0.84_cuda11-archive.tar.xz

# install NCCL
cd /ccs/home/$(whoami)/scratch
git clone https://github.com/NVIDIA/nccl.git
cd nccl
make -j 16 src.build NVCC_GENCODE="-gencode=arch=compute_70,code=sm_70" CUDA_HOME=$CUDA_DIR

# install miniconda
cd /ccs/home/$(whoami)/scratch
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-ppc64le.sh
bash Miniconda3-latest-Linux-ppc64le.sh -b -p $PWD/miniconda3
rm Miniconda3-latest-Linux-ppc64le.sh
