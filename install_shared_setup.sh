conda create --name magma
conda activate magma

# install deepspeed
cd /ccs/home/$(whoami)/scratch
git clone https://github.com/EleutherAI/DeeperSpeed.git
cd DeeperSpeed
git checkout v2.0-summit
pip install -r requirements/requirements.txt
CC='which gcc' CXX='which g++' BUILD_DS_UTILS=1 BUILD_FUSED_ADAM=1 BUILD_FUSED_LAMB=1 DS_BUILD_OPS=0 pip install -e .
sed -i's/default=PDSH_LAUNCHER,/default=JSRUN_LAUNCHER,/g' deepspeed/launcher/runner.py

# install my magma summit fork
cd /ccs/home/$(whoami)/scratch
git clone https://github.com/Alexis-BX/magma
cd magma
git checkout webdataset
pip install -r requirements_summit.txt

cd /ccs/home/$(whoami)/scratch
mkdir hostfiles

./launch_job.sh
