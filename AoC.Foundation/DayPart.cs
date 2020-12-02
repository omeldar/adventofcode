using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC.Foundation
{
    public class DayPart
    {
        public bool SolutionFound { get; set; }
        public void ConsoleInit(int day, string dayTaskName, int partId)
        {
            Console.WriteLine("------");
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("Day" + day + ": " + dayTaskName + " Part " + partId);
            Console.ForegroundColor = ConsoleColor.White;
        }

        public void WriteSolution(string solution)
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine(solution);
            Console.ForegroundColor = ConsoleColor.White;
        }

        public string ReadFile(string path)
        {
            return System.IO.File.ReadAllText(path);
        }
    }
}
