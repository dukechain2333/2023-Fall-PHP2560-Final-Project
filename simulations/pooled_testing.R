library(tidyverse)
library(ggplot2)

set.seed(123456)

simulate_pooled_testing <- function(pool_size, prob_positive, num_iterations, population_size) {
  #' Simulate pooled testing
  #'
  #' @param pool_size The number of samples in each pool
  #' @param prob_positive The probability of a sample being positive
  #' @param num_iterations The number of iterations to run the simulation
  #' @param population_size The size of the population
  #' @return The average number of tests required to test the population

  total_tests <- c()

  for (i in 1:num_iterations) {
    # generate a population of size population_size with prob_positive probability of being positive
    population <- rbinom(population_size, 1, prob_positive)
    # take samples of size pool_size from the population
    samples <- replicate(as.integer(population_size / pool_size), sample(population, pool_size, replace = TRUE))
    # test each sample
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

    # calculate the total number of tests
    total_tests <- c(total_tests, negative_tests + positive_tests * (pool_size + 1))
  }

  return(mean(total_tests))
}