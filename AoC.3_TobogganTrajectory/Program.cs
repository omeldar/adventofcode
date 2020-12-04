using AoC.Foundation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC._3_TobogganTrajectory
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] lines = System.IO.File.ReadAllText(@"K:\AoC20\advent-of-code-2020\AoC.3_TobogganTrajectory\data.txt").Split('\n');
            char[][] data = new char[lines.Length][];

            int row = 0;
            foreach (string line in lines)
            {
                int lengthOfRowWithoutR = 0;
                if(line.Substring(line.Length -1, 1).ToCharArray()[0] == '\r')
                {
                    lengthOfRowWithoutR = line.Length - 1;
                }
                else
                {
                    lengthOfRowWithoutR = line.Length;
                }
                data[row] = new char[lengthOfRowWithoutR];
                int col = 0;
                foreach (char character in line)
                {
                    if(character != '.' && character != '#')
                    {
                        continue;
                    }
                    data[row][col] = character;
                    col++;
                }
                row++;
            }

            PartOne partOne = new PartOne();
            partOne.Execute(data);

            PartTwo partTwo = new PartTwo();
            partTwo.Execute(data);

            Console.ReadKey();
        }
    }

    public class PartOne : DayPart
    {
        public void Execute(char[][] data)
        {
            ConsoleInit(3, "Toboggan Trajectory", 1);

            int treeCount = 0;
            int index = 0;
            
            foreach(char[] line in data)
            {
                if(line[index] == '#')
                {
                    treeCount++;
                }
                if(index + 3 > 30)
                {
                    index = ((3 - (line.Length - index)));
                }
                else
                {
                    index += 3;
                }
            }

            WriteSolution(treeCount.ToString());
        }
    }

    public class PartTwo : DayPart
    {
        public void Execute(char[][] data)
        {
            ConsoleInit(3, "Toboggan Trajectory", 2);

            List<Slope> slopes = new List<Slope>()
            {
                new Slope() {Right = 1, Down = 1},
                new Slope() {Right = 3, Down = 1},
                new Slope() {Right = 5, Down = 1},
                new Slope() {Right = 7, Down = 1},
                new Slope() {Right = 1, Down = 2}
            };

            foreach(Slope slope in slopes)
            {
                int index = 0;
                int treeCount = 0;
                int lineCounter = 0;
                foreach (char[] line in data)
                {
                    lineCounter++;
                    if(lineCounter % 2 == 0 && slope.Down == 2)
                    {
                        continue;
                    }
                    if (line[index] == '#')
                    {
                        treeCount++;
                    }
                    if (index + slope.Right > 30)
                    {
                        index = ((slope.Right - (line.Length - index)));
                    }
                    else
                    {
                        index += slope.Right;
                    }
                }

                slope.TreesInWay = treeCount;
            }

            int solution = 1;

            foreach(Slope slope in slopes)
            {
                solution *= slope.TreesInWay;
            }

            WriteSolution(solution.ToString());
        }
    }
}
