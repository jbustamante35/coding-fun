using SimpleMath

tests = ["addtest", "subtracttest"]

for t in tests
    inclue("$(t).jl")
end

