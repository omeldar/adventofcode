using System;
using System.Net;
using System.Text;
using System.Xml.Linq;

namespace AoC.AppHelpers
{
    /// <summary>
    /// Handles posting the answer to advent of code
    /// </summary>
    public class OutputPoster
    {
        /// <summary>
        /// The configuration instance
        /// </summary>
        public AoCConfig Config { get; set; }
        public OutputPoster(AoCConfig config)
        {
            Config = config;
        }

        /// <summary>
        /// Post the answer to AoC
        /// </summary>
        /// <param name="year">The year of the challenge</param>
        /// <param name="day">The day of the challenge</param>
        /// <returns></returns>
        public async Task<int> Post(int year, int day, int part)
        {
            string url = $"https://adventofcode.com/{year}/day/{day}/answer";  //payload = level: 1  answer: xyz 

            var formContent = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("level", part.ToString()),
                new KeyValuePair<string, string>("answer", Config.LastResult)
            });

            HttpClient myHttpClient = new HttpClient();
            HttpResponseMessage httpResponseMessage = await myHttpClient.PostAsync(url, formContent);

            UXHandler.WriteInColor(httpResponseMessage.Content.ToString() ?? "No response content received.", 
                ConsoleColor.DarkGray, true);

            return (int)httpResponseMessage.StatusCode;
        }
    }
}
