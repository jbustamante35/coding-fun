// Determine age and suggest school level
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
            Console.WriteLine("What old are you? ");
            string ageRaw = Console.ReadLine();
            int age = Convert.ToInt32(ageRaw);          
            Console.WriteLine("So you are {0} years old then.", age);

            if ((age >= 3) && (age <= 7))
            {
                Console.WriteLine("GO PLAY PIANO");
            }
            else if ((age > 7) && (age < 13))
            {
                Console.WriteLine("DON'T MESS WITH @realChristopherWang");    
            }
            else if (age >= 13)
            {
                Console.WriteLine("You are old enough to watch Ping Pong Playa!!1!");
            }
        }
    }
}