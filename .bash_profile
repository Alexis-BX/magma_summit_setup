PROJDIR=$(cat /ccs/home/$(whoami)/.projectid)

function get_nodes(){
        bsub -nnodes "${1:-1}" -alloc_flags gpudefault -W "${2:-120}" -P $PROJDIR -Is /bin/bash
}

function cat_out_70(){
    tail -n ${1:-40} $(ls /ccs/home/$(whoami)/scratch/jobs/magma_pythia70m_out.* | tail -1);echo
}

function cat_out_160(){
    tail -n ${1:-40} $(ls /ccs/home/$(whoami)/scratch/jobs/magma_pythia160m_out.* | tail -1);echo
}

function cat_out_410(){
    tail -n ${1:-40} $(ls /ccs/home/$(whoami)/scratch/jobs/magma_pythia410m_out.* | tail -1);echo
}

function cat_err_70(){
        tail -n ${1:-2} $(ls /ccs/home/$(whoami)/scratch/jobs/magma_pythia70m_err.* | tail -1);echo
}

function cat_err_160(){
        tail -n ${1:-2} $(ls /ccs/home/$(whoami)/scratch/jobs/magma_pythia160m_err.* | tail -1);echo
}

function cat_err_410(){
        tail -n ${1:-2} $(ls /ccs/home/$(whoami)/scratch/jobs/magma_pythia410m_err.* | tail -1);echo
}

alias watch_jobs='watch -n 1 bjobs'
