# Makefile for benchmarking Arrow R versions in Docker

.DEFAULT_GOAL := help

help:  ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n\n"} \
		/^[a-zA-Z_-]+:.*##/ {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2} \
		END {print ""}' $(MAKEFILE_LIST)

build:  ## Build Docker images for each Arrow version
	@for v in $(ARROW_VERSIONS); do \
	  echo "Building image for Arrow $$v..."; \
	  docker build --build-arg ARROW_VERSION=$$v -t $(IMAGE_PREFIX):$$v . ; \
	done

data:  ## Generate test parquet data using Arrow v17
	docker run --rm -v "$$PWD":/workspace -w /workspace $(IMAGE_PREFIX):17.0.0 Rscript generate_data.R

run:  ## Run benchmark test.R under each Arrow version
	@for v in $(ARROW_VERSIONS); do \
	  echo "Running test for Arrow $$v..."; \
	  docker run --rm -v "$$PWD":/workspace -w /workspace --memory=$(MEMORY) --memory-swap=$(MEMORY) \
	    $(IMAGE_PREFIX):$$v /usr/bin/time -v Rscript test.R > result_v$$(echo $$v | tr '.' '_').txt ; \
	done

clean:  ## Delete Docker images for all versions
	@for v in $(ARROW_VERSIONS); do \
	  docker rmi -f $(IMAGE_PREFIX):$$v || true ; \
	done

# Config
ARROW_VERSIONS := 19.0.1.1 20.0.0
MEMORY := 16g
IMAGE_PREFIX := arrowtest
