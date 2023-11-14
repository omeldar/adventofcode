namespace AoC.AppHelpers
{
    /// <summary>
    /// Handles displaying results
    /// </summary>
    public static class UXHandler
    {
        /// <summary>
        /// Display AoC header
        /// </summary>
        /// <param name="header"></param>
        public static void WriteHeader(string header)
        {
            Console.Clear();
            char[] chars = header.ToCharArray();
            foreach (char c in chars)
            {
                if (c == '_')
                    Console.ForegroundColor = ConsoleColor.DarkGray;

                if (c == '/')
                    Console.ForegroundColor = ConsoleColor.DarkYellow;

                if (c == '\\')
                    Console.ForegroundColor = ConsoleColor.Yellow;

                Console.Write(c);

                Console.ForegroundColor = ConsoleColor.White;
            }
            Console.Write('\n');
        }

        /// <summary>
        /// Display post result of last solution result
        /// </summary>
        /// <param name="httpCode">HttpCode received by AoC</param>
        public static void WriteHttpResult(int httpCode)
        {
            if (httpCode >= 200 && httpCode <= 204)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"Posting solution was successful! ({httpCode})");
                Console.ForegroundColor = ConsoleColor.White;
            }
            else
            {
                Console.ForegroundColor= ConsoleColor.Red;
                Console.WriteLine($"Posting failed with http code: {httpCode}");
                Console.ForegroundColor = ConsoleColor.White;
            }
        }

        /// <summary>
        /// Writes output in an other color, setting back afterwards to white.
        /// </summary>
        /// <param name="message">String to write to console</param>
        /// <param name="color">Color to write in</param>
        /// <param name="newLine">If a new line should be added at the end</param>
        public static void WriteInColor(string message, ConsoleColor color, bool newLine = false)
        {
            Console.ForegroundColor = color;
            Console.Write(message);
            Console.ForegroundColor = ConsoleColor.White;
            if (newLine) Console.Write("\n");
        }
    }
}
