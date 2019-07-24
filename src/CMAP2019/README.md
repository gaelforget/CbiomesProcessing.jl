# CMAP 2019

This directory contains the Julia script used to write out interpolated data into NetCDF files to be added in CMAP. Then end goal of this pipeline are NetCDF files each containing multiple fields (these are the "groups") that have been interpolated to a half-degree grid. These files also may contain sums of fields, the Shannon Index of a group of fields, and the full depth integral of a set of fields. The final write to NetCDF is done using the NCTiles.jl package. The interpolation is done in Matlab using gcmfaces. See Cbiomes-Processing.m for that script.

To assist ingest to CMAP, `makencfiles.jl` creates a NetCDF file for each group of fields for each time step, in addition to a single file for each group containing all timesteps.

The full Pipeline is:

1. Edit `setup_pathsflds_cs510.m` (from Cbiomes-Processing.m).
2. Run `runGroups_cs510.m` (from Cbiomes-Processing.m).
3. Run `makencfiles.jl`.

## Directory Structure

The directory structure used for running `makeNCtiles.jl` is as following:

- run_cs510 (top level directory)
  - setup_pathsflds_cs510.m (file)
  - runGroups_cs510.m (file)
  - makeNCfiles.jl (file)
  - submit_interp.sh (if you are using a Slurm cluster)
  - submit_ncfiles.sh (if you are using a Slurm cluster)
  - data (directory)
    - available_diagnostics.log (file)
    - cs510 (directory)
      - README (file)
      - diags_interp
        - Group1
          - Group1Field1
            - Group1Field1.xxx.data (binary interpolated data- one for each timestep)
            - Group1Field1.xxx.meta (metadataa file- one for each timestep)
            - ...
          - Group1Field2
            - ...
        - Group2
          - Group2Field1
          - Group2Field2
          - ...
      - grid (directory containing grid- can be a symlink)
      - ptr (directory- same setup for gud and surf)
        - ptr (symlink to directory containing ptr data)
      - precomp_interp (directory)
        - halfdeg (directory)
          - interp_precomputed.mat (file of interpolation coefficients)

After running `makencfiles.jl` the resulting NetCDF files will be under data_cs510:

- cs510
  - inter_nctiles
    - Group1
      - darwin_v0.2_cs510_Group1_YYYYDDD.nc
      - darwin_v0.2_cs510_Group1_YYYYDDD.nc
      - ...
    - darwin_v0.2_cs510_Group1.nc
    - Group2
      - darwin_v0.2_cs510_Group2_YYYYDDD.nc
      - darwin_v0.2_cs510_Group2_YYYYDDD.nc
      - ...
    - darwin_v0.2_cs510_Group2.nc
    - ...

## Running

Paths can be edited at the top of the file, if directory structure is different. Metadata about the fields (such as units) are taken from the `available_diagnostics.log` file. The file has some amount of checkpointing, so it will pick up where it left off.

This script was written to be submitted to a Slurm Cluster or locally.

To run the script locally, simply execute:

```julia
julia makencfiles.jl
```

This script makes use of Julia's `DistributedArrays.jl` package to write the timestep NetCDF files in parallel if run on a Slurm cluster. A submission script `submit.sh` is provided as an example. It shouldn't take many changes to run in parallel outside of a Slurm cluster.
