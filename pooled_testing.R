library(tidyverse)
library(ggplot2)

simulate_pooled_testing <- function(pool_size, prob_positive, num_iterations, population_size) {
  total_tests <- c()

  for (i in 1:num_iterations) {
    population <- rbinom(population_size, 1, prob_positive)
    samples <- replicate(as.integer(population_size / pool_size), sample(population, pool_size, replace = TRUE))
    tests <- apply(samples, 2, function(x) sum(x) > 0)

    if ("FALSE" %in% tests) {
      negative_tests <- as.numeric(table(tests)["FALSE"])
    }else {
      negative_tests <- 0
    }

    if ("TRUE" %in% tests) {
      positive_tests <- as.numeric(table(tests)["TRUE"])
    }else {
      positive_tests <- 0
    }

    total_tests <- c(total_tests, negative_tests + positive_tests * (pool_size + 1))
  }

  return(mean(total_tests))
}