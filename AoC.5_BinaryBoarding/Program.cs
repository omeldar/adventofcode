using AoC._5_BinaryBoarding;
using AoC.Foundation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC._5_BinaryBoarding
{
    class Program
    {
        static void Main(string[] args)
        {
            Solution solution = new Solution();
            IEnumerable<object> objects = solution.Solve(System.IO.File.ReadAllText(@"K:\AoC20\advent-of-code-2020\AoC.5_BinaryBoarding\data.txt"));

            foreach(object _object in objects)
            {
                Console.WriteLine(_object.ToString());
            }

            Console.ReadKey();
        }
    }

    public class Solution
    {
        public IEnumerable<object> Solve(string input)
        {
            yield return PartOne(input);
            yield return PartTwo(input);
        }

        int PartOne(string input) => Seats(input).Max();

        int PartTwo(string input)
        {
            var seats = Seats(input);
            var (min, max) = (seats.Min(), seats.Max());
            return Enumerable.Range(min, max - min + 1).Single(id => !seats.Contains(id));
        }

        HashSet<int> Seats(string input) =>
            input
                .Replace("B", "1")
                .Replace("F", "0")
                .Replace("R", "1")
                .Replace("L", "0")
                .Split('\n')
                .Select(row => Convert.ToInt32(row.Split('\r')[0], 2))
                .ToHashSet();
    }

    public class PartOne : DayPart
    {
        public static void Execute(List<BoardingPass> boardingPasses)
        {
            ConsoleInit(5, "Binary Boarding", 1);

            BoardingPass boardingPassWithHighestId = null;

            foreach(BoardingPass boardingPass in boardingPasses)
            {
                int[] rowRange = { 0, 127 };    // to make id divideable by 2 (127 + 1)
                int[] colRange = { 0, 7 };      // to make id divideable by 2 (7 + 1)
                int partitioningCounter = 0;
                //boardingPass.SeatPositioning = new char[] { 'F', 'B', 'F', 'B', 'B', 'F', 'F', 'R', 'L', 'R' };
                //boardingPass.SeatPositioning = new char[] { 'B', 'B', 'B', 'B', 'B', 'B', 'B', 'R', 'R', 'R' };
                boardingPass.SeatPositioning = new char[] { 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'L', 'L', 'L' };

                foreach (char partitioning in boardingPass.SeatPositioning)
                {
                    switch (partitioning)
                    {
                        case 'F':
                            rowRange[1] = Day5Helper.DivideBy2ForXRounds(128, partitioningCounter + 1) + rowRange[0];
                            break;
                        case 'B':
                            rowRange[0] = Day5Helper.DivideBy2ForXRounds(128, partitioningCounter + 1) + rowRange[0];
                            break;
                        case 'R':
                            colRange[0] = Day5Helper.DivideBy2ForXRounds(8, partitioningCounter - 6) + colRange[0];  // (partitioningCounter + 1) - 7 (because 7 F/B chars in front of R/L chars) --> partitioningCounter - 6
                            break;
                        case 'L':
                            colRange[1] = Day5Helper.DivideBy2ForXRounds(8, partitioningCounter - 6) + colRange[0];
                            break;
                        default:
                            throw new ArgumentException("Unknown partitioning value: '" + partitioning + "'");
                    }

                    if (partitioningCounter == 9)
                    {
                        int row = -1;
                        int col = -1;

                        if (boardingPass.SeatPositioning[6] == 'F')
                            row = rowRange.GetLowestValue();
                        else
                            row = rowRange.GetHighestValue();

                        if (boardingPass.SeatPositioning[9] == 'L')
                            col = colRange.GetLowestValue();
                        else
                            col = colRange.GetHighestValue();

                        boardingPass.Id = ((row * 8) + col);

                        boardingPassWithHighestId = boardingPassWithHighestId ?? boardingPass;

                        if (boardingPass.Id > boardingPassWithHighestId.Id)
                            boardingPassWithHighestId = boardingPass;

                    }
                    partitioningCounter++;
                }
            }
            WriteSolution(boardingPassWithHighestId.Id.ToString());
        }
    }

    public static class Day5Helper
    {
        public static int DivideBy2ForXRounds(int number, int rounds)
        {
            for (int i = 0; i < rounds; i++)
            {
                number /= 2;
            }
            return number;
        }
    }
}