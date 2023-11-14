using System.Reflection;

namespace AoC.AppHelpers
{
    public static class RunHelper
    {
        /// <summary>
        /// Returns the type found by namespace and className
        /// </summary>
        /// <param name="assembly">Assembly to look in</param>
        /// <param name="nameSpace">Namespace where class file lies in</param>
        /// <param name="className">Classname</param>
        /// <returns></returns>
        public static Type GetTypesInNamespace(Assembly assembly, string nameSpace, string className)
        {
            return
              assembly.GetTypes()
                      .FirstOrDefault(t => string.Equals(t.Namespace, nameSpace + "." + className, StringComparison.Ordinal))
                      ?? throw new Exception("Type not found by given namespace and classname.");
        }

        /// <summary>
        /// Returns the types found by namespace
        /// </summary>
        /// <param name="assembly">Assembly to look in</param>
        /// <param name="nameSpace">Namespace where class file lies in</param>
        /// <returns>All types found in that namespace</returns>
        public static Type[] GetTypesInNamespace(Assembly assembly, string nameSpace)
        {
            return
              assembly.GetTypes()
                      .Where(t => string.Equals(t.Namespace, nameSpace, StringComparison.Ordinal) &&
                        !t.Name.Contains("<>") && // Exclude types with "<>" in their names
                        !t.Name.Contains("__DisplayClass"))
                      .ToArray()
                      ?? throw new Exception("No types found in given namespace");
        }

        public static string ReturnStringArgument(string[] args, int index)
        {
            try
            {
                return args[index];
            }
            catch (Exception e)
            {
                Console.WriteLine($"Could not load argument in pos {index}, exiting with following exception: ");
                Console.WriteLine(e.Message.ToString() + "\n\t" + e.ToString());
                Environment.Exit(-1);
            }
            return null;
        }

        public static int ReturnIntArgument(string[] args, int index)
        {
            try
            {
                if (args.Length > index)
                    return int.Parse(args[index]);

                throw new Exception("Not enough arguments provided");
            }
            catch (Exception e)
            {
                Console.WriteLine($"Could not parse argument in pos {index}, exiting with following exception: ");
                Console.WriteLine(e.Message.ToString() + "\n\t" + e.ToString());
                Environment.Exit(-1);
            }
            return -1;
        }

        public static bool ReturnBoolArgument(string[] args, int index)
        {
            try
            {
                return bool.Parse(args[index]);
            }
            catch (Exception e)
            {
                Console.WriteLine($"Could not parse argument in pos {index}, exiting with following exception: ");
                Console.WriteLine(e.Message.ToString() + "\n\t" + e.ToString());
                Environment.Exit(-1);
            }
            return false;
        }
    }
}
