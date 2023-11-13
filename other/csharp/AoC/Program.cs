using AoC;
using System.Diagnostics;
using System.Reflection;

Console.Title = "Advent of Code Runner!";
string header = @"
_____/\\\\\\\\\_____________/\\\_________________________________________________________________________________________________/\\\\\____________________/\\\\\\\\\_________________________/\\\__________________        
 ___/\\\\\\\\\\\\\__________\/\\\_______________________________________________________________________________________________/\\\///__________________/\\\////////_________________________\/\\\__________________       
  __/\\\/////////\\\_________\/\\\_____________________________________________________/\\\_____________________________________/\\\____________________/\\\/__________________________________\/\\\__________________      
   _\/\\\_______\/\\\_________\/\\\____/\\\____/\\\______/\\\\\\\\____/\\/\\\\\\_____/\\\\\\\\\\\_________________/\\\\\______/\\\\\\\\\________________/\\\__________________/\\\\\____________\/\\\_______/\\\\\\\\__     
    _\/\\\\\\\\\\\\\\\____/\\\\\\\\\___\//\\\__/\\\_____/\\\/////\\\__\/\\\////\\\___\////\\\////________________/\\\///\\\___\////\\\//________________\/\\\________________/\\\///\\\_____/\\\\\\\\\_____/\\\/////\\\_    
     _\/\\\/////////\\\___/\\\////\\\____\//\\\/\\\_____/\\\\\\\\\\\___\/\\\__\//\\\_____\/\\\___________________/\\\__\//\\\_____\/\\\__________________\//\\\______________/\\\__\//\\\___/\\\////\\\____/\\\\\\\\\\\__   
      _\/\\\_______\/\\\__\/\\\__\/\\\_____\//\\\\\_____\//\\///////____\/\\\___\/\\\_____\/\\\_/\\______________\//\\\__/\\\______\/\\\___________________\///\\\___________\//\\\__/\\\___\/\\\__\/\\\___\//\\///////___  
       _\/\\\_______\/\\\__\//\\\\\\\/\\_____\//\\\_______\//\\\\\\\\\\__\/\\\___\/\\\_____\//\\\\\________________\///\\\\\/_______\/\\\_____________________\////\\\\\\\\\___\///\\\\\/____\//\\\\\\\/\\___\//\\\\\\\\\\_ 
        _\///________\///____\///////\//_______\///_________\//////////___\///____\///_______\/////___________________\/////_________\///_________________________\/////////______\/////_______\///////\//_____\//////////__
                                                                 ";
Console.WriteLine(header);

Console.WriteLine("\n\n\n");

int year = 0;
int day = 0;
bool timeUnitAlwaysNanoseconds = false;

if(args.Length >= 2)
{
    try
    {
        year = int.Parse(args[0]);
        day = int.Parse(args[1]);
        if (args.Length > 2)
            timeUnitAlwaysNanoseconds = bool.Parse(args[2]);
    } catch (Exception ex)
    {
        Console.WriteLine("Parsing arguments failed with exception:");
        Console.WriteLine(ex.ToString());
        Console.WriteLine("Program closing...");
        Environment.Exit(-1);
    }
}
else
{
    Console.WriteLine("Not all necessary arguments provided. Minimum required arguments are 2: $run <year> <day> <part>");
    Environment.Exit(-1);
}

Console.WriteLine($"Running AoC solution of year {year}, day {day}");

string nameSpace = $"AoC._{year}.Day{day}";
Type[] types = RunHelper.GetTypesInNamespace(Assembly.GetExecutingAssembly(), nameSpace);

if (types.Length is 0)
{
    Console.WriteLine($"found {types.Length} types in namespace {nameSpace}. Solution for this day might not yet be created. Program is closing.");
    Environment.Exit(-1);
}

foreach (Type type in types)
{
    // Create an instance of the type
    object instance = Activator.CreateInstance(type) ?? throw new Exception($"Instance of type {type} could not be created.");

    // Assume there's a method called GetStringValue in each class
    // You can change this to match your method name or constructor logic
    MethodInfo method = type.GetMethod("Run") ?? throw new Exception($"Method 'Run' not implemented in type {type}.");

    if (method is not null && instance is not null)
    {
        // Start Stopwatch
        var watch = System.Diagnostics.Stopwatch.StartNew();

        // Invoke the method and get the result
        string result = (string)(method.Invoke(instance, null) ?? throw new Exception(""));
        watch.Stop();

        double ticks = watch.ElapsedTicks;
        double ns = (watch.ElapsedTicks / Stopwatch.Frequency) * 1000000000;
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
        Console.ForegroundColor= ConsoleColor.Green;
        Console.WriteLine($"\t{result}");
        Console.ForegroundColor = ConsoleColor.DarkBlue;
        Console.WriteLine($"\tin {time} {unit}");
        Console.ForegroundColor = ConsoleColor.White;
    }
}