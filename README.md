# 2023-Fall-PHP2560-Final-Project: Simulation on Pooled Testing

This is the final project for 2023 Fall PHP 2560. It was conducted by William Qian and Dingxuan Zhang.

## Project Description
Pooled testing is a technique used to increase the efficiency of testing for various infectious diseases, including COVID-19.
It involves combining samples from multiple individuals into a single pool and testing the pool as a whole. This approach 
can significantly reduce the number of tests needed, particularly when the prevalence of the disease is low.

In this project, we will simulate the process of pooled testing and find the optimal pool size for different prevalence rates, 
and demonstrate the result through a Shiny app. Different plots, tables and user inputs will be available in the app.

## Project Structure
Different from normal build of shiny app, this app is built on a `HTML` template, which is located in the `www` folder. 
The `app.R` file is the main file of the app. 

The reason why we choose this structure is that we want to make the app more beautiful and more interactive. By implementing with
`Tailwind CSS`, the user interface now looks more modern and beautiful. However, by doing such practice, we have to give up some
features that are available in normal shiny app, meaning that we have to build those features from scratch. Luckily, we made it.

The app is divided into three parts: `Introduction`, `Simulation` and `Conclusion`:
- `Introduction`: This part is the introduction of pooled testing, which takes the first page of the app. It includes 
the basic idea of pooled testing, the advantages of using pooled testing. And we also include the math behind pooled testing.
- `Simulation`: This part is the main part of the app. It includes the simulation of pooled testing, the plots and tables.
  - **Optimized Pool Size over Positive Rate**: This simulation allows users to input the positive rate, population size 
  and number of iterations as parameters. The app will then simulate the pooled testing process and find the optimized pool size under the given parameters,
  and plot the result in a line chart.
  - **Positive Rate as Definite**: In order to see the trend of the optimized pool size under different positive rate, we
    set the positive rate as a definite value. In this simulation, users can input the population size and number of iterations as parameters.
  - **Data Demonstration**: This part allows user to directly check the data we obtained from the simulation. Users can 
  input the population size and number of iterations as parameters.
- `Conclusion`: This part is the conclusion of the app. It includes the summary of the findings we obtained from the simulation.

## How we design the simulation?

