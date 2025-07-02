# generate_data.R
library(arrow)

nvert <- 10E6
nedge <- 20E7

vert <- data.frame(id = seq_len(nvert))
edges <- data.frame(
  src = sample(nvert, nedge, replace = TRUE),
  dst = sample(nvert, nedge, replace = TRUE),
  type = sample(1:10, nedge, replace = TRUE)
)

write_parquet(vert, "vertices.parquet")
write_parquet(edges, "edges.parquet")

