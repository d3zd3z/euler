# Run all of the problems.

names = filter(x -> startswith(x, "pr") && endswith(x, ".jl"), readdir("."))
for name in names
    print(name, ": ")
    m = Module()
    Base.include(m, name)
end
