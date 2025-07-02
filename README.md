
# Testing code between different versions of the Arrow R package

Files:
- test.R: containing code to be run
- generate_data.R: code to generate any necessary data
- Dockerfile: dockerfile needed to build different R versions
- Makefile: instructions for running/building; specify package versions here

## Running


Clean results from previous run

`make clean`


Build Docker images

`make build`


Generate data

`make data`


Run test.R for each version

`make run`


## Run interactively to check e.g. a segfault

Run an interactive version of a container

`make VERSION=20.0.0 shell`

Install gdb (we should update the Dockerfile) to do this in advance
`apt-get update && apt-get install -y gdb`

Run R with gdb attached

`R -d gdb`

`run`

Load test file

`source("test.R")`

## Check (from outside of the container) for out of memory (OOM)

`journalctl -k | grep -i 'killed process'`
