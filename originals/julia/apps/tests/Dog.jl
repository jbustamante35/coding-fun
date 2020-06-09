# Test julia classes
type Dog
    Name::String
    Legs::Int64
    Tail::Int64	
    MaxBarkVolume::Int64

    Bark::Function
    Walk::Function
    Trick::Function

    function Dog(name::String)
        this = new ()
        this.Name = name
        this.Legs = 4
        this.Tail = 1
        this.MaxBarkVolume = 10

       this.Bark = function (vol::Int64)
            bark = (vol / this.MaxBarkVolume)
            return bark
        end
    
        this.Walk = function (speed::Int64)
            walk = @printf("Walking at speed %d \n", speed)
            return walk
        end

        this.Trick = function (trick::String)
            trick = @printf("Performed trick: %s \n", trick)
        end
        
        return this
    end
end
 
dog = Dog("Max")
dog.Bark

