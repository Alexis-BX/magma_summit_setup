# magma_summit_setup

Launch compute node:
```
echo Enter your project ID
read ID
echo $ID > .projectid

bsub -nnodes 1 -alloc_flags gpudefault -W 1:00 -P $(cat .projectid) -Is /bin/bash
```
