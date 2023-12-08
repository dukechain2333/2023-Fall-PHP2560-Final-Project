library(tidyverse)
library(ggplot2)
source("simulations/pooled_testing.R")

# This simulation set PROB_POSITIVE as definite value, and compare the average number of tests with different pool size
# to find the optimal pool size under certain probability of positive.

set.seed(123456)

# simulation parameters
POPULATION_SIZE <- 1000
PROB_POSITIVE <- 0.02
MIN_POOL_SIZE <- 2
MAX_POOL_SIZE <- 40
NUM_ITERATIONS <- 1000

AvgTests <- c()
# pool_size iterations
for (pool_size in MIN_POOL_SIZE:MAX_POOL_SIZE) {
  avg_tests <- simulate_pooled_testing(pool_size, PROB_POSITIVE, NUM_ITERATIONS, POPULATION_SIZE)
  AvgTests <- c(AvgTests, avg_tests)
}

results <- data.frame(PoolSize = MIN_POOL_SIZE:MAX_POOL_SIZE, AvgTests = AvgTests)

print(results)

# plot the results
ggplot(results, aes(x = PoolSize, y = AvgTests)) +
  geom_line() +
  labs(title = "Pooled Testing Simulation",
       x = "Pool Size",
       y = "Average Number of Tests")
