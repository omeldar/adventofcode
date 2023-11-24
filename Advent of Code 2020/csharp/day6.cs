using AoC.Foundation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC._6_CustomCustoms
{
    class Program
    {
        static void Main(string[] args)
        {
            PartOne.Execute(ReadFile());
            PartTwo.Execute(ReadFile());

            Console.ReadKey();
        }

        private static List<Group> ReadFile()
        {
            string[] lines = System.IO.File.ReadAllLines(@"K:\AoC20\advent-of-code-2020\AoC.6_CustomCustoms\data.txt");
            //string[] lines = System.IO.File.ReadAllLines(@"K:\AoC20\advent-of-code-2020\AoC.6_CustomCustoms\example-data.txt");

            List<Group> groups = new List<Group>();

            Group currentGroup = new Group();

            foreach (string line in lines)
            {
                if (string.IsNullOrEmpty(line))
                {
                    groups.Add(currentGroup);
                    currentGroup = new Group();
                    continue;
                }

                Person person = new Person();
                person.QuestionsAnsweredTrue = line.ToCharArray().ToList();
                currentGroup.People.Add(person);
            }
            groups.Add(currentGroup);

            return groups;
        }
    }

    public class PartOne : DayPart
    {
        public static void Execute(List<Group> groups)
        {
            ConsoleInit(6, "Custom Customs", 1);

            int sum = 0;

            foreach (Group group in groups)
            {
                List<char> answeredYes = new List<char>();

                int runCounter = 0;
                foreach (Person person in group.People)
                {
                    if (runCounter == 0)
                    {
                        answeredYes = person.QuestionsAnsweredTrue;
                        runCounter++;
                        continue;
                    }

                    List<char> tmp = new List<char>();

                    foreach (char question in person.QuestionsAnsweredTrue)
                        if (!answeredYes.Any(q => q == question))
                            tmp.Add(question);

                    foreach (char question in tmp)
                        answeredYes.Add(question);

                    runCounter++;
                }
                sum += answeredYes.Count;
            }

            WriteSolution(sum);
        }
    }

    public class PartTwo : DayPart
    {
        public static void Execute(List<Group> groups)
        {
            ConsoleInit(6, "Custom Customs", 2);

            int sum = 0;

            foreach (Group group in groups)
            {
                List<char> answeredYes = new List<char>();

                int runCounter = 0;
                foreach (Person person in group.People)
                {
                    if (runCounter == 0)
                    {
                        answeredYes = person.QuestionsAnsweredTrue;
                        runCounter++;
                        continue;
                    }

                    List<char> tmp = new List<char>();

                    foreach (char question in answeredYes)
                        if (!person.QuestionsAnsweredTrue.Any(q => q == question))
                            tmp.Add(question);

                    foreach (char question in tmp)
                        answeredYes.Remove(question);

                    runCounter++;
                }
                sum += answeredYes.Count;
            }

            WriteSolution(sum);
        }
    }
}
