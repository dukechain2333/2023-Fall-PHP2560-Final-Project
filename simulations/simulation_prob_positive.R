source("simulations/pooled_testing.R")

# This simulation set PROB_POSITIVE as a variable, and compare the optimal pool size with different probability of positive.

set.seed(123456)

# simulation parameters
POPULATION_SIZE <- 1000
MIN_POOL_SIZE <- 2
MAX_POOL_SIZE <- 30
NUM_ITERATIONS <- 100

results <- data.frame(ProbPositive = c(), PoolSize = c(), MinAvgTests = c())

# prob_positive iterations
for (prob_positive in seq(0.01, 1, 0.01)) {
  avg_tests <- c()
  # pool_size iterations
  for (pool_size in MIN_POOL_SIZE:MAX_POOL_SIZE) {
    avg_tests <- c(avg_tests, simulate_pooled_testing(pool_size, prob_positive, NUM_ITERATIONS, POPULATION_SIZE))
  }

  # if the average number of tests is greater than the population size, then the test numbers are set to the population size
  if (min(avg_tests) >= POPULATION_SIZE) {
    results <- rbind(results, data.frame(ProbPositive = prob_positive, PoolSize = 1, MinAvgTests = POPULATION_SIZE))
  } else {
    results <- rbind(results, data.frame(ProbPositive = prob_positive, PoolSize = which.min(avg_tests) + 1, MinAvgTests = min(avg_tests)))
  }
}

print(results)

# plot the results
ggplot(results, aes(x = ProbPositive, y = PoolSize)) +
  geom_line() +
  labs(title = "Pooled Testing Simulation",
       x = "Probability of Positive",
       y = "Optimal Pool Size")