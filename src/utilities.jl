# byproducts.jl

"""
    StartWorkers(nwrkrs::Int)

Start workers if needed.
"""
function StartWorkers(nwrkrs::Int)
   set_workers = nwrkrs
   nworkers() < set_workers ? addprocs(set_workers) : nothing
   nworkers()
end

"""
    TaskDriver(indx,fn)

Broacast / distribute task (fn; e.g. loop_task1) over indices (indx; e.g. file indices)

Examples:

```
using CbiomesProcessing, Distributed, SparseArrays
TaskDriver(1,CbiomesProcessing.loop_task1)

StartWorkers(4)
@everywhere using CbiomesProcessing, SparseArrays
TaskDriver(1:4,CbiomesProcessing.loop_task1)
```

Visualize results:

```
using FortranFiles, Plots
k=1
recl=720*360*4
fil="diags_interp/ETAN/ETAN.0000000732.data"
f =  FortranFile(fil,"r",access="direct",recl=recl,convert="big-endian")
tmp=read(f,rec=k,(Float32,(720,360))); close(f)
heatmap(tmp)
```
"""
function TaskDriver(indx::Union{UnitRange{Int},Array{Int,1},Int},fn::Function)
    i=collect(indx)
    length(i)>1 ? i=distribute(i) : nothing
    isa(i,DArray) ? println(i.indices) : nothing
    fn.(i)
end
