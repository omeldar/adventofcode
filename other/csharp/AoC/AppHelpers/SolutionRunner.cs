using AoC.SolutionHelpers;
using System.Diagnostics;
using System.Reflection;

namespace AoC.AppHelpers
{
    public class SolutionRunner
    {
        public static string Run(int year, int day, bool timeUnitAlwaysNanoseconds)
        {
            Console.WriteLine($"Running AoC solution of year {year}, day {day}");

            string nameSpace = $"AoC._{year}.Day{day}";
            Type[] types = RunHelper.GetTypesInNamespace(Assembly.GetExecutingAssembly(), nameSpace);

            if (types.Length is 0)
            {
                Console.WriteLine($"found {types.Length} types in namespace {nameSpace}. Solution for this day might not yet be created. Program is closing.");
                Environment.Exit(-1);
            }
            string[] results = new string[types.Length];
            int part = 0;

            foreach (Type type in types)
            {
                Console.WriteLine($"Name: {type.Name},\t Namespace: {type.Namespace}");
                // Create an instance of the type
                object instance = Activator.CreateInstance(type) ?? throw new Exception($"Instance of type {type} could not be created.");

                // Assume there's a method called GetStringValue in each class
                // You can change this to match your method name or constructor logic
                MethodInfo method = type.GetMethod("Run") ?? throw new Exception($"Method 'Run' not implemented in type {type}.");

                if (method is not null && instance is not null)
                {
                    // Start Stopwatch
                    var watch = Stopwatch.StartNew();

                    // Invoke the method and get the result
                    string baseUrl = string.Empty;

                    string result = (string)(method.Invoke(instance, new object[] 
                        { AoCFileReader.ReadAsString($"{baseUrl}{year}/Day{day}/input.txt") }) ?? throw new Exception(""));
                    watch.Stop();

                    results[part] = result;

                    double ticks = watch.ElapsedTicks;
                    double ns = watch.ElapsedTicks / Stopwatch.Frequency * 1000000000;
                    string time = ns.ToString();
                    string unit = "ns";

                    if (ns > 10000 && !timeUnitAlwaysNanoseconds)
                    {
                        double ms = (double)ns / 1000;
                        time = ms.ToString();
                        unit = "ms";
                    }

                    if (ns < 10 && !timeUnitAlwaysNanoseconds)
                    {
                        time = ticks.ToString();
                        unit = "ticks";
                    }

                    string runner = "<namespace not found> ";
                    if (type.Namespace is not null)
                        runner = type.Namespace.Split(".")[1].Substring(1) + " " + type.Namespace.Split(".")[2] + " " + type.Name + " ";

                    // Display result to user
                    Console.ForegroundColor = ConsoleColor.Yellow;
                    Console.Write($"{runner}");
                    Console.ForegroundColor = ConsoleColor.White;
                    Console.WriteLine("created result:");
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine($"\t{result}");
                    Console.ForegroundColor = ConsoleColor.DarkBlue;
                    Console.WriteLine($"\tin {time} {unit}");
                    Console.ForegroundColor = ConsoleColor.White;
                }
                part++;
            }
            return results[results.Length - 1];
        }
    }
}
