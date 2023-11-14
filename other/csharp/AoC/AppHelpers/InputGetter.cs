using System.Net;

namespace AoC.AppHelpers
{
    /// <summary>
    /// Handles getting of Advent of Code input
    /// </summary>
    public class InputGetter
    {
        /// <summary>
        /// The configuration instance
        /// </summary>
        public AoCConfig Config { get; set; }
        public InputGetter(AoCConfig config)
        {
            Config = config;
        }

        /// <summary>
        /// Gets the input from the aoc webpage and saves it into a file
        /// </summary>
        /// <param name="year">The year of the challenge to get the input from.</param>
        /// <param name="day">The day of the challenge to get the input from.</param>
        /// <param name="_cookie">The cookie of your current session to get your input, since every user has a different one.</param>
        /// <param name="filename">The Filename of the target file.</param>
        /// <returns></returns>
        public async Task Get(int year, int day, string filename = "input.txt")
        {
            if (!File.Exists(filename))
            {
                var uri = new Uri("https://adventofcode.com");
                var cookies = new CookieContainer();
                cookies.Add(uri, new Cookie("session", Config.Cookie));
                using var file = new FileStream($"{year}/Day{day}/{filename}", FileMode.Create, FileAccess.Write, FileShare.None);
                using var handler = new HttpClientHandler() { CookieContainer = cookies };
                using var client = new HttpClient(handler) { BaseAddress = uri };
                using var response = await client.GetAsync($"/{year}/day/{day}/input");
                using var stream = await response.Content.ReadAsStreamAsync();
                await stream.CopyToAsync(file);
            }
        }
    }
}
