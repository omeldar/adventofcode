using AoC.Abstract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC._2023.Day1
{
    public class Part1 : IPart
    {
        public string Run(string input)
        {
            List<int> result = new List<int>();
            foreach (string line in input.Split('\n'))
            {
                List<int> values = new List<int>();
                foreach(char _ch in line)
                {
                    try
                    {
                        if (Char.IsNumber(_ch))
                        {
                            int value = Convert.ToInt32(_ch.ToString());
                            values.Add(value);
                        }
                    } catch (Exception ex)
                    {
                        continue;
                    }
                }
                result.Add(Convert.ToInt32(values[0].ToString() + values[values.Count - 1].ToString()));
            }
            int sum = 0;
            foreach(int value in result)
            {
                sum += value;
            }
            return sum.ToString();
        }
    }
}
