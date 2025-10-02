# Estimating the value of π using a Monte Carlo Algorithm
AMS 595 — MATLAB Project 1  

## Project Description:
This project uses a Monte Carlo algorithm to estimate the value of π. This is achieved by obtaining the probability of randomly chosen points in the x-y plane that fall within a specific region (quarter of a circle with a radius of 1, centered at the origin) and the area ([0,1] X [0,1]) of that region. Points that fall within the specific region are colored red, while points not inside the specific region are colored blue. The area of this quarter circle is π/4, and to calculate the π estimate, it becomes π = 4 * P, with P representing points inside the circle divided by the total number of points generated.

## This Project Contains Three Tasks to Compute π:
NOTE: These three tasks are all performed in MATLAB. All three tasks use different approaches to compute π and are explained further below.


### Task 1 - For-loop with Fixed Number of Random Points
- Generates random points for an increasing Number of Runs.  
- Computes π Estimate, Absolute Error, and Elapsed Time.  
- Plots in Task:  
  - Computed π versus Number of Points
    - Reference line of True π included
  - Absolute error versus Number of Points
  - Absolute error (Precision) vs Elapsed Time (Computational Cost)

### Task 2: While-loop to Compute π to a Specified Level of Precision
NOTE: This is a modified version of Task 1.
- Does **NOT** rely on the true value of π.  
- Uses stability checks to see if significant values are equal between previous and current π.
- Once total stability checks are met (manually implemented), the while-loop is finished and produces the following:
  - The final π estimate
  - The total number of iterations needed to achieve each level of precision
  - Elapsed time
 

### Task 3: Function to Compute π
NOTE: This is a modified version of Task 2.
- User-defined level of precision as input.
- Generate a plot for the random points:
  - Fall inside the circle, **RED**
  - Fall outside the circle, **BLUE**
- The final Computed value of π is displayed on the plot and in the command window.
- The final computed value of π is returned by the function.
