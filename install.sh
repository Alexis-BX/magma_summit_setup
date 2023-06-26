PROJDIR=CSC499

mkdir /gpfs/alpine/$PROJDIR/scratch/$(whoami)

cp setup.sh /gpfs/alpine/$PROJDIR/scratch/$(whoami)

cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
source /gpfs/alpine/$PROJDIR/scratch/$(whoami)/setup.sh

# install cudnn
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
cp /gpfs/alpine/csc499/proj-shared/env_setup/cudnn-linux-ppc64le-8.7.0.84_cuda11-archive.tar.xz .
tar -xvf cudnn-linux-ppc64le-8.7.0.84_cuda11-archive.tar.xz
rm cudnn-linux-ppc64le-8.7.0.84_cuda11-archive.tar.xz

# install NCCL
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
git clone https://github.com/NVIDIA/nccl.git
cd nccl
make -j 16 src.build NVCC_GENCODE="-gencode=arch=compute_70,code=sm_70" CUDA_HOME=$CUDA_DIR

# install miniconda
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-ppc64le.sh
bash Miniconda3-latest-Linux-ppc64le.sh -b -p $PWD/miniconda3

# setup conda
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
source /gpfs/alpine/$PROJDIR/scratch/$(whoami)/setup.sh
conda init
conda deactivate
conda create -n gpt-neox -y python=3.9
cd miniconda3
mv lib/libcrypto* ..

# install pytorch. It tends to be challenging to install pytorch on the POWER architecture, so use Quentin's. If you can't access this file, contact me (qubitquentin@gmail.com) or build your own wheel from source.
pip3 install /gpfs/alpine/csc499/proj-shared/env_setup/torch-1.13.0a0+gitbb7fd1f-cp39-cp39-linux_ppc64le.whl
pip3 install /gpfs/alpine/csc499/proj-shared/env_setup/torchvision-0.15.0a0+035d99f-cp39-cp39-linux_ppc64le.whl

# install mpi4py
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
pip install cython
git clone https://github.com/mpi4py/mpi4py.git
cd mpi4py
git checkout 5ffef9cf44aeaacbc32c5a1cad76f8d5e1a2e3d5
CC=$(which mpicc) CXX=$(which mpicxx) python setup.py build --mpicc=$(which mpicc)
CC=$(which mpicc) CXX=$(which mpicxx) pip install -e .

# install apex
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
cp /gpfs/alpine/csc499/proj-shared/env_setup/apex .
cd apex
pip install -r requirements.txt
# sed -i 's/def check_cuda_torch_binary_vs_bare_metal(cuda_dir):/def check_cuda_torch_binary_vs_bare_metal(cuda_dir):\n    return/g' setup.py
# module load gcc/9.3.0
pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

# install deepspeed
# !!!NOTE!!! Most DS op compilations will fail since we're on the POWER arch. I'd recommend building DS from source without ops, then setting the .cache directory to a non-default location since $HOME isn't accessible on compute nodes when DS will build them JIT.
git clone https://github.com/EleutherAI/DeeperSpeed.git
cd DeeperSpeed
git checkout v2.0-summit
pip install -r requirements/requirements.txt
DS_BUILD_OPS=0 pip install -e .

# setup hostfiles
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
mkdir hostfiles

# install my magma summit fork
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
git clone https://github.com/Alexis-BX/magma
cd magma
pip install -r requirements_summit.txt

# install my magma summit fork with webdataset
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
git clone https://github.com/Alexis-BX/magma magma_webdataset
cd magma_webdataset
pip install -r requirements_summit.txt

# install my magma summit fork with model distributing
cd /gpfs/alpine/$PROJDIR/scratch/$(whoami)
git clone https://github.com/floatingsnake/gpt-neox magma_neox
cd magma_neox
git checkout magma
pip install -r requirements/requirements.txt
pip install -r requirements/requirements-magma.txt
pip install urllib3==1.26.2
