module CbiomesProcessing

using YAML, SparseArrays, MeshArrays, Dates
using Distributed, DistributedArrays, FortranFiles
#using MITgcmTools

include("utilities.jl")
include("fileloops.jl")
include("examples.jl")

export StartWorkers, TaskDriver
export cbioproc_example1, cbioproc_example2

#export AverageYear

end # module
