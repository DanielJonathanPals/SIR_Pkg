using DynamicalSystems, Plots, CairoMakie, Logging

include("structs.jl")



"""
toDynSys(mdl::epidemic_models)

    Returns a ContinuousDynamicalSystem corresponding to the
    problem at hand.

    # Arguments
    -'mdl::epidemic_models': The epidemic model to be investigated.
"""
function toDynSys(mdl::SIR_model)
    u0 = [mdl.S0,mdl.I0,mdl.R0]
    if sum(u0) != 1
        @warn "The inital conditions do not sum up to 1"
    end
    prms = [mdl.β,mdl.γ]
    function f(u,p,t)
        β,γ = p
        S,I,R = u
        return SVectos{3}(-β*S*I,β*S*I-γ*I,γ*I)
    end
    return ContinuousDynamicalSystem(f,u0,prms)
end

function toDynSys(mdl::SIRV_model)
    u0 = [mdl.S0,mdl.I0,mdl.R0,mdl.V0]
    if sum(u0) != 1
        @warn "The inital conditions do not sum up to 1"
    end
    prms = [mdl.β,mdl.γ,mdl.v]
    function f(u,p,t)
        β,γ,v = p
        S,I,R,V = u
        return SVector{4}(-β*S*I-v*S,β*S*I-γ*I,γ*I,v*S)
    end
    return ContinuousDynamicalSystem(f,u0,prms)
end



"""
info(mdl::epidemic_models)

    Prints the information stored in the Model at hand
"""
function info(mdl::SIR_model)
    println("SIR model with β = $(mdl.β), γ = $(mdl.γ) and initial conditions
    S₀ = $(mdl.S0), I₀ = $(mdl.I0), R₀ = $(mdl.R0)")
end

function info(mdl::SIRV_model)
    println("SIRV model with β = $(mdl.β), γ = $(mdl.γ), v = $(mdl.v) and initial conditions 
    S₀ = $(mdl.S0), I₀ = $(mdl.I0), R₀ = $(mdl.R0), V₀ = $(mdl.V0)")
end



function check_vars(vars)
    if typeof(mdl) == SIR_model
        if  !issubset(vars,["S","I","R"])
            @error "vars is an array which can only contain elements in ['S','I','R']"
        end
    else
        if  !issubset(vars,["S","I","R","V"])
            @error "vars is an array which can only contain elements in ['S','I','R','V']"
        end
    end
    return nothing
end


"""
plot_timeseries(mdl::epidemic_models;t=collect(0:0.1:100),vars=["S","I","R","V"])

    Plots a timeevolution of the model.

    # Arguments
    -'mdl::epidemic_models': Model to be plotted
    -'T': Total timeevolution
    -'Δt': Size of the time steps
    -'vars': Variables to be displayed
"""
function plot_timeseries(mdl::epidemic_models;T=10,Δt=0.1,vars=["S","I","R"])
    check_vars(vars)
    plot_dict = Dict("S" => 1, "I" => 2, "R" => 3, "V" => 4)

    ds = toDynSys(mdl)
    tr = trajectory(ds,T;Δt = Δt)
    times = collect(0:Δt:T)

    fig = Figure(resolution = (1200, 600))
    ax = Axis(fig[1, 1], xlabel = "t / days", title = "Development of the epidemic")
    for i in vars
        lines!(ax,times,tr[:,plot_dict[i]],linewidth=3,label=i)
    end
    axislegend()
    fig
end



"""
plot_phase_diagram(mdl::epidemic_models;vars=["S","I"])

    Plots the Phasediagram of the model w.r.t. given Variables

    #Arguments
    -'mdl::epidemic_models': Model to be plotted
    -'vars': Variables to be displayed
"""
function plot_phase_diagram(mdl::epidemic_models;vars=["S","I"])
    length(vars) == 2 || @error "Vars must have length 2"
    check_vars(vars)
    plot_dict = Dict("S" => 1, "I" => 2, "R" => 3, "V" => 4)

    ds = toDynSys(mdl)
    tr = trajectory(ds,1000)

    fig = Figure(resolution = (600, 600))
    ax = Axis(fig[1, 1], xlabel = vars[1], ylabel=vars[2], title = "Phase Diagram")
    lines!(ax,tr[:,plot_dict[vars[1]]],tr[:,plot_dict[vars[2]]],linewidth=3)
    fig
end


"""
function to test the testing
"""
function add(x,y)
    return x+y
end
