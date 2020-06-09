//Test out some C# code
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication3
{
    class Program
    {
        static void Main (string[] args)
        {

            var voldemort = "Tom Riddle";
            Console.WriteLine("Voldemort AKA {0}", voldemort);
            Console.WriteLine("{0} is of datatype {1}", voldemort, voldemort.GetTypeCode());
        }
    }
}