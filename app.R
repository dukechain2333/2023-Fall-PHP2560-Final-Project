library(shiny)
library(ggplot2)
library(plotly)
library(DT)

# Define server logic for random distribution app ----
server <- function(input, output) {

  # Simulation 1 server logic
  # Use reactive to update the parameters when the user changes them
  processed_data_simulation_1 <- reactive({
    positive_rate <- input$positive_rate

    if (is.null(positive_rate)) {
      positive_rate <- 0.02
    } else {
      positive_rate <- as.numeric(positive_rate)
    }

    population <- as.integer(input$pr_definite_pop_options)
    num_iterations <- as.integer(input$pr_definite_iter_options)


    file_name <- sprintf("data/population_%d_iterations_%d.csv", population, num_iterations)
    data_simulation_1 <- read.csv(file_name)
    pr <- gsub("\\.", "_", sprintf("prob_%0.2f", positive_rate))

    # Return the processed data
    data_simulation_1[, c("PoolSize", pr)]
  })

  output$simulation_1 <- renderPlot({
    data <- processed_data_simulation_1()
    pr <- colnames(data)[2]

    ggplot(data, aes(x = PoolSize, y = !!sym(pr))) +
      geom_line() +
      labs(title = "Pooled Testing Simulation",
           x = "Pool Size",
           y = "Average Number of Tests")
  })

  # Simulation 2 server logic
  # Use reactive to update the parameters when the user changes them
  processed_data_simulation_2 <- reactive({
    population <- as.integer(input$pr_var_pop_options)
    num_iterations <- as.integer(input$pr_var_iter_options)


    file_name <- sprintf("data/population_%d_iterations_%d.csv", population, num_iterations)
    data_simulation_2 <- read.csv(file_name)[1:30,]

    probs <- seq(0.01, 1, 0.01)
    min_avg_tests <- numeric(ncol(data_simulation_2) - 1)
    optimized_n <- numeric(ncol(data_simulation_2) - 1)

    # if the average number of tests is greater than the population size, then the test numbers are set to the population size
    for (i in 2:ncol(data_simulation_2)) {
      min_row <- which.min(data_simulation_2[[i]])
      if (data_simulation_2[min_row, i] > population) {
        min_avg_tests[i - 1] <- population
        optimized_n[i - 1] <- 1
      } else {
        min_avg_tests[i - 1] <- data_simulation_2[min_row, i]
        optimized_n[i - 1] <- data_simulation_2[min_row, 1]
      }
    }

    data.frame(PositiveProb = probs, MinAvgTests = min_avg_tests, OptimizedN = optimized_n)
  })

  output$simulation_2 <- renderPlot({
    data <- processed_data_simulation_2()

    ggplot(data, aes(x = PositiveProb, y = OptimizedN)) +
      geom_line() +
      labs(title = "Pooled Testing Simulation",
           x = "Probability of Positive",
           y = "Optimal Pool Size")
  })

  # Data table server logic
  processed_data_table <- reactive({
    population <- as.integer(input$table_pop_options)
    num_iterations <- as.integer(input$table_iter_options)


    file_name <- sprintf("data/population_%d_iterations_%d.csv", population, num_iterations)
    data_table <- read.csv(file_name)[1:30,]

    # Return the processed data
    data_table
  })

  output$table <- renderTable({
    data <- processed_data_table()
    colnames(data) <- c("Pool Size", seq(0.01, 1, 0.01))
    data
  }, align = 'c')
}

shinyApp(ui = htmlTemplate("www/index.html"), server)