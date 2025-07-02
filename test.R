# test.R
library(arrow)
library(dplyr)

sessionInfo()

vert <- read_parquet("vertices.parquet")
str(vert)

con <- open_dataset("edges.parquet")
con

dta <- con |> filter(src %in% vert$id, dst %in% vert$id) |> collect()

nrow(dta)
