using AoC.Abstract;
using AoC.SolutionHelpers.Enumerators;
using AoC.SolutionHelpers.Structures;

namespace AoC._2016.Day1
{
    public class Part1 : IPart
    {
        public string Run(string input)
        {
            List<string> instructions = input.Split(", ").ToList();

            int x = 0;
            int y = 0;
            
            Compass<string> compass = new Compass<string>(new string[] { "N", "E", "S", "W" });

            instructions
                .Select(i => (compass.MoveAndGet(i.First() == 'L' ? Direction.Left : Direction.Right) + i.Substring(1)))
                .ToList()
                .Select(i => (i[0] == 'N') ? (y += int.Parse(i[1..])) : ((i[0] == 'E') ? (x += int.Parse(i[1..])) : ((i[0] == 'S') ? (y -= int.Parse(i[1..])) : (x -= int.Parse(i[1..])))));

            Console.WriteLine($"{x}, {y}");
            return (x + y).ToString();
        }
    }
}
