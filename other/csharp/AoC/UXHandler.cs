namespace AoC
{
    public static class UXHandler
    {
        public static void WriteHeader(string header)
        {
            Console.Clear();
            char[] chars = header.ToCharArray();
            foreach(char c in chars)
            {
                if (c == '_')
                    Console.ForegroundColor = ConsoleColor.DarkGray;

                if (c == '/')
                    Console.ForegroundColor = ConsoleColor.DarkYellow;

                if (c == '\\')
                    Console.ForegroundColor = ConsoleColor.Yellow;

                Console.Write(c);

                Console.ForegroundColor= ConsoleColor.White;
            }
            Console.Write('\n');
        }
    }
}
