using AoC.Foundation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC._2_PasswordPhilosophy
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = @"K:\AoC20\advent-of-code-2020\AoC.2_PasswordPhilosophy\data.txt";
            string[] lines = System.IO.File.ReadAllText(path).Split('\n');
            List<DataO> data = new List<DataO>();

            foreach(string line in lines)
            {
                DataO dataO = new DataO();

                dataO.LowestAmount = Convert.ToInt32(line.Split(':')[0].Split(' ')[0].Split('-')[0]);
                dataO.HighestAmount = Convert.ToInt32(line.Split(':')[0].Split(' ')[0].Split('-')[1]);
                dataO.Character = line.Split(':')[0].Split(' ')[1].ToCharArray()[0];
                dataO.Password = line.Split(':')[1];
                data.Add(dataO);
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
        public void Execute(List<DataO> data)
        {
            ConsoleInit(2, "Password Philosophy", 1);
            int correctPasswordsCounter = 0;
            foreach(DataO dataO in data)
            {
                int amount = dataO.Password.Count(x => x == dataO.Character);
                if (amount >= dataO.LowestAmount && amount <= dataO.HighestAmount)
                    correctPasswordsCounter++;
            }

            WriteSolution(correctPasswordsCounter.ToString());
        }
    }

    public class PartTwo : DayPart
    {
        public void Execute(List<DataO> data)
        {
            ConsoleInit(2, "Password Philosophy", 2);
            int correctPasswordsCounter = 0;
            foreach(DataO datao in data)
            {
                int appearanceCount = 0;
                if (datao.Password.Substring(datao.LowestAmount, 1) == datao.Character.ToString())
                    appearanceCount++;

                if (datao.Password.Substring(datao.HighestAmount, 1) == datao.Character.ToString())
                    appearanceCount++;

                if (appearanceCount == 1)
                    correctPasswordsCounter++;
            }

            WriteSolution(correctPasswordsCounter.ToString());
        }
    }
}
