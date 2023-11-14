using System.Configuration;

namespace AoC.AppHelpers
{
    /// <summary>
    /// A config instance
    /// </summary>
    public class AoCConfig
    {
        /// <summary>
        /// Creates a config
        /// </summary>
        public AoCConfig()
        {
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);

            if (config.AppSettings.Settings["Cookie"] == null)
                config.AppSettings.Settings.Add("Cookie", string.Empty);

            if (config.AppSettings.Settings["LastCookieUpdate"] == null)
                config.AppSettings.Settings.Add("LastCookieUpdate", DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"));

            if (config.AppSettings.Settings["LastResult"] == null)
                config.AppSettings.Settings.Add("LastResult", string.Empty);

            config.Save(ConfigurationSaveMode.Minimal);
        }
        /// <summary>
        /// Cookie of your current sessions
        /// </summary>
        public string Cookie
        {
            get
            {
                CheckCookieLastTimeUpdated();
                return ConfigurationManager.AppSettings.Get("Cookie") ?? string.Empty;
            }
            set
            {
                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                config.AppSettings.Settings["Cookie"].Value = value;
                config.AppSettings.Settings["LastCookieUpdate"].Value = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
                config.Save(ConfigurationSaveMode.Modified);
                ConfigurationManager.RefreshSection("appSettings");
            }
        }

        /// <summary>
        /// Last time the cookie value has been updated
        /// </summary>
        public string LastCookieUpdate
        {
            get
            {
                return ConfigurationManager.AppSettings.Get("LastCookieUpdate") ?? string.Empty;
            }
        }

        /// <summary>
        /// Result of last executed AoC solution
        /// </summary>
        public string LastResult
        {
            get
            {
                return ConfigurationManager.AppSettings.Get("LastResult") ?? string.Empty;
            }
            set
            {
                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                config.AppSettings.Settings["LastResult"].Value = value;
                config.Save(ConfigurationSaveMode.Modified);
                ConfigurationManager.RefreshSection("appSettings");
            }
        }

        private void CheckCookieLastTimeUpdated()
        {
            DateTime lastCookieUpdate = DateTime.Parse(LastCookieUpdate);

            if (DateTime.Now > lastCookieUpdate.AddYears(1))
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"\nLast cookie update was more than a year ago. Cookie might become invalid soon!\n");
                Console.ForegroundColor = ConsoleColor.White;
            }
        }
    }
}
