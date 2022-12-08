# magma_summit_setup

Launch compute node:
```
echo Enter your project ID
read PROJECTID

bsub -nnodes 1 -alloc_flags gpudefault -W 1:00 -P $PROJECTID -Is /bin/bash
```
