namespace AoC.AppHelpers
{
    public class GlobalExceptionHandler
    {
        public static void UnhandledExceptionTrapper(object sender, UnhandledExceptionEventArgs e)
        {
            Console.ForegroundColor= ConsoleColor.Red;
            Console.WriteLine(e.ExceptionObject.ToString());
            Console.ForegroundColor= ConsoleColor.White;
            Console.WriteLine("Press Enter to continue");
            Console.ReadLine();
            Environment.Exit(1);
        }
    }
}
