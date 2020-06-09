 myTable = "DraCALA_Analyzed.txt";

 open(myTable) do f
   line = 1
   while !eof(f)
     x = readline(f)
     println("$x")
     line += 1
   end
 end


  for f in filter(x -> ismatch(r"\.txt", x), readdir())
       println(f)
   end

include("fourrandom.jl");

open("testData.txt", "w") do f
    write(f, "First\tSecond\tThird\tFourth\n");
    for i in 1:20
        n1, n2, n3, n4 = fourrandom()
        write(f, "$n1\t$n2\t$n3\t$n4\n")
    end
end

randData = rand(8,12);
writedlm("randPlate.txt", randData);