using AoC.AppHelpers;

Console.Title = "Advent of Code Runner!";

string header = @"
_____/\\\\\\\\\_____________________________/\\\\\\\\\___        
 ___/\\\\\\\\\\\\\________________________/\\\////////____       
  __/\\\/////////\\\_____________________/\\\/_____________      
   _\/\\\_______\/\\\_______/\\\\\_______/\\\_______________     
    _\/\\\\\\\\\\\\\\\_____/\\\///\\\____\/\\\_______________    
     _\/\\\/////////\\\____/\\\__\//\\\___\//\\\______________   
      _\/\\\_______\/\\\___\//\\\__/\\\_____\///\\\____________  
       _\/\\\_______\/\\\____\///\\\\\/________\////\\\\\\\\\___ 
        _\///________\///_______\/////_____________\/////////____
                                                                 ";
UXHandler.WriteHeader(header);

string action = string.Empty;

try
{
    action = args[0];
}
catch (Exception ex)
{
    Console.WriteLine("Action has not been provided.");
    Console.WriteLine(ex.ToString());
    Console.WriteLine("Program closing...");
    Environment.Exit(-1);
}

// local variables and arguments
int year = 0;
int day = 0;
int part = 0;
bool timeUnitAlwaysNanoseconds = false;

InputGetter inputGetter = null!;

AoCConfig configuration = new AoCConfig();

switch (action)
{
    case "run":
        year = RunHelper.ReturnIntArgument(args, 1);
        day = RunHelper.ReturnIntArgument(args, 2);
        timeUnitAlwaysNanoseconds = false;
        if (args.Length > 3)
            timeUnitAlwaysNanoseconds = RunHelper.ReturnBoolArgument(args, 3);

        string result = SolutionRunner.Run(year, day, timeUnitAlwaysNanoseconds);
        configuration.LastResult = result;

        Console.Write($"\nResult of last solution has been saved for posting.\n\tCurrent Value:\n\t");
        UXHandler.WriteInColor($"{configuration.LastResult}", ConsoleColor.Magenta, true);
        break;
    case "get-input":
        inputGetter ??= new InputGetter(configuration);
        year = RunHelper.ReturnIntArgument(args, 1);
        day = RunHelper.ReturnIntArgument(args, 2);
        if (args.Length > 3)
            configuration.Cookie = RunHelper.ReturnStringArgument(args, 3);

        await inputGetter.Get(year, day);

        string filepath = $"{year}/Day{day}/input.txt";

        if (File.Exists(filepath))
            Console.WriteLine($"Input file '{filepath}' created successfully.");
        break;
    case "get-cookie":
        Console.WriteLine($"Your cookie value is: {configuration.Cookie}");
        break;
    case "set-cookie":
        configuration.Cookie = RunHelper.ReturnStringArgument(args, 1);
        Console.WriteLine("Getting cookie value, so you can confirm setting cookie succeeded...");
        Console.WriteLine($"Cookie value now: '{configuration.Cookie}'");
        break;
    case "post-answer":
        year = RunHelper.ReturnIntArgument(args, 1);
        day = RunHelper.ReturnIntArgument(args, 2);
        part = RunHelper.ReturnIntArgument(args, 3);
        OutputPoster poster = new OutputPoster(configuration);

        int httpCode = await poster.Post(year, day, part);

        UXHandler.WriteHttpResult(httpCode);
        break;
    case "help":
        Console.WriteLine(":: run\t<year | int>\t<day | int>\t<timeUnitAlwaysNanoseconds | boolean?>\n");
        Console.WriteLine(":: get-input\t<year | int>\t<day | int>\t<session | string>\n");
        Console.WriteLine(":: get-cookie\t\n");
        Console.WriteLine(":: set-cookie\t<session | string>\n");
        Console.WriteLine(":: post-answer\t<year | int>\t<day | int>\t<part | int>\n");
        break;
    default:
        Console.WriteLine($"No action '{action}' found.");
        break;
}

Console.WriteLine("Program is ending.");
#if DEBUG
Console.WriteLine("Press a key to exit program.");
Console.ReadKey();
#endif
Environment.Exit(1);