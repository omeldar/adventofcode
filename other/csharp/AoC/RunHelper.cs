using System.Reflection;

namespace AoC
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
                      .FirstOrDefault(t => String.Equals(t.Namespace, nameSpace + "." + className, StringComparison.Ordinal)) 
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
                      .Where(t => String.Equals(t.Namespace, nameSpace, StringComparison.Ordinal))
                      .ToArray()
                      ?? throw new Exception("No types found in given namespace");
        }
    }
}
