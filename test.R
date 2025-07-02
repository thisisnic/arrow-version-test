# test.R
library(arrow, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)

sessionInfo()

vert <- read_parquet("vertices.parquet")
con <- open_dataset("edges.parquet")

dta <- con |> filter(src %in% vert$id, dst %in% vert$id) |> collect()

nrow(dta)

print("Done")
