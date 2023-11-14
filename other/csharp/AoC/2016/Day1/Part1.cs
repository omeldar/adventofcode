using AoC.Abstract;
using AoC.SolutionHelpers.Enumerators;
using AoC.SolutionHelpers.Structures;

namespace AoC._2016.Day1
{
    public class Part1 : IPart
    {
        public string Run(string input)
        {
            List<string> instructions = input.Split(',').ToList();

            int x = 0;
            int y = 0;
            
            Compass<string> compass = new Compass<string>(new string[] { "N", "E", "S", "W" });

            List<string> instructions_compass = instructions
                .Select(i => (compass.MoveAndGet(i.First() == 'L' ? Direction.Left : Direction.Right) + i.Substring(1)))
                .ToList();

            instructions_compass.ForEach(i => Console.WriteLine(i));

            return (x + y).ToString();
        }
    }
}
