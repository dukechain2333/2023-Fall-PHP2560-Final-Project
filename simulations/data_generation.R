library(tidyverse)
library(ggplot2)
source("simulations/pooled_testing.R")

# This program runs the simulations and saves the results to a csv file. 15 csv files were generated in total.

set.seed(123456)

# simulation parameters
POPULATION_SIZE <- c(100, 500, 1000, 5000, 10000)
NUM_ITERATIONS <- c(100, 1000, 10000)
MIN_POOL_SIZE <- 2
MAX_POOL_SIZE <- 50

# population_size iterations
for (population_size in POPULATION_SIZE) {
  # num_iterations iterations
  for (num_iterations in NUM_ITERATIONS) {
    results <- data.frame(PoolSize = MIN_POOL_SIZE:MAX_POOL_SIZE)
    # prob_positive iterations
    for (prob_positive in seq(0.01, 1, 0.01)) {
      print(sprintf("population_size: %d, num_iterations: %d, positive_prob: %f", population_size, num_iterations, prob_positive))

      AvgTests <- c()
      # pool_size iterations
      for (pool_size in MIN_POOL_SIZE:MAX_POOL_SIZE) {
        avg_tests <- simulate_pooled_testing(pool_size, prob_positive, num_iterations, population_size)
        AvgTests <- c(AvgTests, avg_tests)
      }

      column_name <- gsub("\\.", "_", sprintf("prob_%0.2f", prob_positive))
      results[[column_name]] <- AvgTests
    }
    # save data
    file_name <- sprintf("data/population_%d_iterations_%d.csv", population_size, num_iterations)
    write.csv(results, file_name, row.names = FALSE)
  }
}
