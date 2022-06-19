using DocStringExtensions


abstract type epidemic_models end


"""
struct SIR_model <: epidemtic_models

$(TYPEDFIELDS)
"""
struct SIR_model <: epidemic_models
    "Transmission rate (i.e. probability that an infected person infects a suceptibale person"
    β::Float64
    "Recouvery rate"
    γ::Float64
    "Initial number of suceptibles"
    S0::Number
    "Initial number of infected"
    I0::Number
    "Initial number of rocouvered"
    R0::Number
end


"""
struct SIRV_model <: epidemtic_models

    $(TYPEDFIELDS)
"""
struct SIRV_model <: epidemic_models
    "Transmission rate (i.e. probability that an infected person infects a suceptibale person"
    β::Float64
    "Recouvery rate"
    γ::Float64
    "Vaccination rate"
    v::Float64
    "Initial number of suceptibles"
    S0::Number
    "Initial number of infected"
    I0::Number
    "Initial number of rocouvered"
    R0::Number
    "Initial number of vaccinated"
    V0::Number
end
