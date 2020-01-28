module CbiomesProcessing

using YAML, FortranFiles, JLD, Dates
using Distributed, DistributedArrays
using SparseArrays, MeshArrays
using MITgcmTools

include("utilities.jl")
include("fileloops.jl")
include("examples.jl")

export StartWorkers, TaskDriver
export cbioproc_example1, cbioproc_example2

#export AverageYear

end # module
