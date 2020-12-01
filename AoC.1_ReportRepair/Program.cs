using AoC.Foundation;
using System;
using System.Collections.Generic;

namespace AoC._1_ReportRepair
{
    class Program
    {
        static void Main(string[] args)
        {
            PartOne partOne = new PartOne();
            partOne.Execute();

            PartTwo partTwo = new PartTwo();
            partTwo.Execute();

            Console.ReadKey();
        }
    }

    public class PartOne : DayPart
    {
        public void Execute()
        {
            ConsoleInit(1, "ReportRepair", 1);
            string text = System.IO.File.ReadAllText(@"K:\AoC20\AoC-2020\AoC.1_ReportRepair\data.txt");
            string[] dataSeperated = text.Split('\n');
            List<int> dataList = new List<int>();
            foreach (string value in dataSeperated)
            {
                dataList.Add(Convert.ToInt32(value));
            }

            foreach (int dataEntry1 in dataList)
            {
                if (SolutionFound)
                    break;

                foreach (int dataEntry2 in dataList)
                {
                    if (dataEntry1 == dataEntry2 || SolutionFound)
                        break;

                    if (dataEntry1 + dataEntry2 == 2020)
                    {
                        Console.WriteLine("Entry 1: " + dataEntry1);
                        Console.WriteLine("Entry 2: " + dataEntry2);
                        WriteSolution("Factor: " + dataEntry1 * dataEntry2);
                        SolutionFound = true;
                    }
                }
            }
        }
    }
    public class PartTwo : DayPart
    {
        public void Execute()
        {
            ConsoleInit(1, "ReportRepair", 2);
            string text = System.IO.File.ReadAllText(@"K:\AoC20\AoC-2020\AoC.1_ReportRepair\data.txt");
            string[] dataSeperated = text.Split('\n');
            List<int> dataList = new List<int>();
            foreach (string value in dataSeperated)
            {
                dataList.Add(Convert.ToInt32(value));
            }

            foreach (int dataEntry1 in dataList)
            {
                if (SolutionFound)
                    break;
                foreach (int dataEntry2 in dataList)
                {
                    if (SolutionFound)
                        break;
                    if (dataEntry1 == dataEntry2)
                        continue;

                    foreach (int dataEntry3 in dataList)
                    {
                        if (SolutionFound)
                            break;
                        if (dataEntry1 == dataEntry3 || dataEntry2 == dataEntry3)
                            continue;


                        if (dataEntry1 + dataEntry2 + dataEntry3 == 2020)
                        {
                            Console.WriteLine("Entry 1: " + dataEntry1);
                            Console.WriteLine("Entry 2: " + dataEntry2);
                            Console.WriteLine("Entry 3: " + dataEntry3);
                            WriteSolution("Factor: " + dataEntry1 * dataEntry2 * dataEntry3);
                            SolutionFound = true;
                        }
                    }
                }
            }
        }
    }
}
