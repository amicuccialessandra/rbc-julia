# DSGE Model Simulation (Julia)

This project is a small experiment where I try to replicate a basic DSGE (Dynamic Stochastic General Equilibrium) model using Julia, based on an exercise I previously did in MATLAB/Dynare during my university course.

---

## The Model Includes

* Cobb-Douglas production function
* Capital accumulation
* A productivity (TFP) shock process

---

## ✅ What I Did

* Translated a Dynare `.mod` file into a Julia script
* Defined parameters and steady state values
* Simulated the model response to a shock
* Plotted impulse response functions (IRFs)

---

## ⚙ Technologies

* Julia v1.10.2
* Plots.jl for graphing
* Basic arrays and loops for simulation

---

## 🔍 Notes

I’m still learning Julia, so this script is mostly a first attempt to understand how it works compared to MATLAB. The code may not be optimal, but it helps me get more familiar with Julia’s syntax and workflow.

---

## 📈 Output

The model simulates the impact of a productivity shock over 40 periods and plots the IRFs for key variables: output, capital, consumption, investment, and TFP.

---

## 🚀 Usage

To run the simulation and generate the IRFs, follow these steps:

1. Make sure you have Julia v1.10.2 installed.
2. Install dependencies by running:

   ```julia
   import Pkg; Pkg.add("Plots")
   ```
3. Run the simulation script:

   ```julia
   include("dsge.jl")
   ```
4. The script will output plots of the IRFs saved to your working directory.


