mkdir /ccs/home/$(whoami)/scratch

cp setup.sh /ccs/home/$(whoami)/scratch

module load cuda/11.0.3 gcc/10.2.0 git

# install cudnn
cd /ccs/home/$(whoami)/scratch
cp /gpfs/alpine/csc499/proj-shared/cudnn-linux-ppc64le-8.7.0.84_cuda11-archive.tar.xz .
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

# setup conda
cd /ccs/home/$(whoami)/scratch
source /ccs/home/$(whoami)/scratch/setup.sh
conda init
conda create -n gpt-neox -y python=3.8

# install pytorch. It tends to be challenging to install pytorch on the POWER architecture, so use Quentin's. If you can't access this file, contact me (qubitquentin@gmail.com) or build your own wheel from source.
pip3 install /gpfs/alpine/csc499/proj-shared/torch-1.13.0a0+gitbb7fd1f-cp39-cp39-linux_ppc64le.whl

# install mpi4py
cd /ccs/home/$(whoami)/scratch
git clone https://github.com/mpi4py/mpi4py.git
cd mpi4py
git checkout 3.1.2
CC=$(which mpicc) CXX=$(which mpicxx) python setup.py build --mpicc=$(which mpicc)
CC=$(which mpicc) CXX=$(which mpicxx) python setup.py install

# install deepspeed
# !!!NOTE!!! Most DS op compilations will fail since we're on the POWER arch. I'd recommend building DS from source without ops, then setting the .cache directory to a non-default location since $HOME isn't accessible on compute nodes when DS will build them JIT.
cd /ccs/home/$(whoami)/scratch
git clone https://github.com/microsoft/DeepSpeed.git
cd DeepSpeed
pip install -r requirements/requirements.txt
DS_BUILD_OPS=0 pip install -e .

# install apex
cd /ccs/home/$(whoami)/scratch
git clone https://github.com/NVIDIA/apex.git
cd apex
pip install -r requirements.txt
# EDIT SETUP.PY HERE
### pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./


# install my magma summit fork
cd /ccs/home/$(whoami)/scratch
git clone https://github.com/Quentin-Anthony/magma
cd magma
### pip install -r requirements_summit.txt
