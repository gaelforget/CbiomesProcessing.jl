#!/bin/bash

#SBATCH -o make_ncfiles.log-%j
#SBATCH -n 16

julia makeNCfiles.jl