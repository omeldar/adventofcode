namespace AoC.SolutionHelpers
{
    public static class AoCFileReader
    {
        public static string ReadAsString(string path)
        {
            return File.ReadAllText(path);
        }
    }
}
