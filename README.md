# magma_summit_setup
Setup:
```
echo [project ID] > .projectid
```

Launch compute node:
```
bsub -nnodes 1 -alloc_flags gpudefault -W 1:00 -P $(cat /ccs/home/$(whoami)/.projectid) -Is /bin/bash
```

Thank you so much to Quentin for finding all of this!
