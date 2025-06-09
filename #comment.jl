using ModelingToolkit        
using DifferentialEquations   
using Symbolics               
using ForwardDiff             
using NLsolve                 
using Optim                   
using Turing                  
using Distributions           
using Plots    

#defining model 
@parameters t
@variables C(t) Y(t) K(t) N(t) A(t) I(t) #makes symbolic time-dependent functions (like C(t), etc.)
#this is thanks  ModelingToolkit. It represent what I would put "var" in matlab 

@variables C_p C_m K_p K_m N_p N_m A_p A_m I_p I_m  # (+1), (-1)

@parameters alpha beta theta_l delta ro_a sigma_a

#function to compete the steady state 
function steady_state(params)
    alpha, beta, theta_l, delta = params

    # Guess for N (labor supply)
    N = 0.2
    K = N / (((1 / beta) - (1 - delta)) / (1 - alpha))^(1 / alpha)
    I = delta * K
    Y = K^(1 - alpha) * N^alpha
    C = alpha * (K / N)^(1 - alpha) * (1 - alpha) / theta_l
    A = 1.0

    return (C=C, Y=Y, K=K, N=N, I=I, A=A)
end

# Calibration
α = 0.58
β = 0.988
θ = 1.0
δ = 0.025
ρ = 0.9
σ = 0.1

params = (α, β, θ, δ)
ss = steady_state(params)

#in Julia we don't have "varexo" to define the shock, but we have to manually simulate 
T = 40
A = fill(1.0, T)
eps_a = zeros(T)
eps_a[1] = σ  # one standard deviation shock
#This creates an array of shocks drawn from a normal distribution.

for t in 2:T
    A[t] = (1 - ρ) + ρ * A[t-1] + eps_a[t]
end


C = zeros(T)
Y = zeros(T)
K = zeros(T)
N = zeros(T)
I = zeros(T)

# Initial conditions (steady state)
K[1] = ss.K
A[1] = ss.A

#Even though in Dynare we can write the model using time shift, in Julia you have to simulate the model over time manually, creating a loop
for t in 2:T
    # Use production function to solve for N given A and K
    N[t] = ss.N  # in full model, solve labor equation here numerically

    Y[t] = A[t] * (K[t-1]^(1 - α)) * (N[t]^α)
    C[t] = Y[t] - δ * K[t-1]
    I[t] = Y[t] - C[t]
    K[t] = (1 - δ) * K[t-1] + I[t]
end



#This computes a first-order approximation, and plots impulse response functions (IRFs) for 40 periods.
plot(1:T, A, label="A (TFP)", lw=2)
plot!(1:T, Y, label="Output Y")
plot!(1:T, C, label="Consumption C")
plot!(1:T, K, label="Capital K")
plot!(1:T, I, label="Investment I")


