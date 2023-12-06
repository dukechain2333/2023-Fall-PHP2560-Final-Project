library(tidyverse)
library(ggplot2)
source("simulations/pooled_testing.R")

# This simulation set PROB_POSITIVE as definite value, and compare the average number of tests with different pool size
# to find the optimal pool size under certain probability of positive.

set.seed(123456)

POPULATION_SIZE <- c(100)
NUM_ITERATIONS <- c(100)
MIN_POOL_SIZE <- 2
MAX_POOL_SIZE <- 50

for (population_size in POPULATION_SIZE) {
  for (num_iterations in NUM_ITERATIONS) {
    results <- data.frame(PoolSize = MIN_POOL_SIZE:MAX_POOL_SIZE)
    for (prob_positive in seq(0.01, 1, 0.01)) {
      print(sprintf("population_size: %d, num_iterations: %d, positive_prob: %f", population_size, num_iterations, prob_positive))

      AvgTests <- c()
      for (pool_size in MIN_POOL_SIZE:MAX_POOL_SIZE) {
        avg_tests <- simulate_pooled_testing(pool_size, prob_positive, num_iterations, population_size)
        AvgTests <- c(AvgTests, avg_tests)
      }

      column_name <- gsub("\\.", "_", sprintf("prob_%0.2f", prob_positive))
      results[[column_name]] <- AvgTests
    }
    file_name <- sprintf("data/population_%d_iterations_%d.csv", population_size, num_iterations)
    write.csv(results, file_name, row.names = FALSE)
  }
}
