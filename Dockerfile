# Dockerfile
FROM rocker/r-ver:4.5.0

# System dependencies — shared across versions
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev libgit2-dev time \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Shared R packages — also shared across versions
RUN Rscript -e "install.packages(c('remotes', 'dplyr'), repos='https://cloud.r-project.org')"

# Version-specific arrow install (this breaks the cache per version)
ARG ARROW_VERSION
RUN Rscript -e "remotes::install_version('arrow', version = Sys.getenv('ARROW_VERSION'), repos='https://cloud.r-project.org')"

# Workdir and copy only once
WORKDIR /workspace
COPY . /workspace
