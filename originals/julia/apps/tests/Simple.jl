type Simple
    a::Int
    b::Int

    add::Function
    subtract::Function

    function Simple(x::Int, y::Int)
        this = new()
        this.a = x
        this.b = y
        
        this.add = function()
            return a + b
        end

        this.subtract = function()
            return a - b
        end

        return this
    end
end
