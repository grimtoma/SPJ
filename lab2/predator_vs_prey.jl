abstract type Agent end
abstract type Animal <: Agent end
abstract type Plant <: Agent end

mutable struct Grass <: Plant
    const id::Int
    size::Int
    const max_size::Int
end

Grass(id,m=10) = Grass(id, rand(1:m), m)

function Base.show(io::IO, g::Grass)
    x = g.size/g.max_size * 100
    # hint: to type the leaf in the julia REPL you can do:
    # \:herb:<tab>
    print(io,"🌿 #$(g.id) $(round(Int,x))% grown")
end


mutable struct Sheep <: Animal
    id::Int
    energy::Float64
    Δenergy::Float64
    reprprob::Float64
    foodprob::Float64
end

Sheep(id, e=4.0, Δe=0.2, pr=0.8, pf=0.6) = Sheep(id,e,Δe,pr,pf)

function Base.show(io::IO, s::Sheep)
    e = s.energy
    d = s.Δenergy
    pr = s.reprprob
    pf = s.foodprob
    print(io,"🐑 #$(s.id) E=$e ΔE=$d pr=$pr pf=$pf")
end

mutable struct Wolf <: Animal
    const id::Int
    energy::Float64
    const Δenergy::Float64
    const reprprob::Float64
    const foodprob::Float64
end

Wolf(id, e=10.0, Δe=8.0, pr=0.1, pf=0.2) = Wolf(id,e,Δe,pr,pf)

function Base.show(io::IO, w::Wolf)
    e = w.energy
    d = w.Δenergy
    pr = w.reprprob
    pf = w.foodprob
    print(io,"🐺 #$(w.id) E=$e ΔE=$d pr=$pr pf=$pf")
end

mutable struct World{A<:Agent}
    agents::Dict{Int,A}
    max_id::Int
end

function World(agents::Vector{<:Agent})
    max_id = maximum(a.id for a in agents)
    World(Dict(a.id=>a for a in agents), max_id)
end

# optional: overload Base.show
function Base.show(io::IO, w::World)
    println(io, typeof(w))
    for (_,a) in w.agents
        println(io,"  $a")
    end
end

function eat!(sheep::Sheep, grass::Grass, world::World)
    sheep.energy += sheep.Δenergy * grass.size
    grass.size = 0
    nothing
end

function eat!(wolf::Wolf, sheep::Sheep, world::World)
    wolf.energy += wolf.Δenergy * sheep.energy
    kill_agent!(sheep, world)
end

function kill_agent!(agent::Agent, world::World)
    delete!(world.agents, agent.id)
end

function reproduce!(animal::Animal, world::World)
    animal.energy /= 2
    new_animal = deepcopy(animal)
    new_animal.id = world.max_id + 1
    world.agents[new_animal.id] = new_animal
    world.max_id += 1
end

