using AoC.Abstract;

namespace AoC._2023.Day1
{
    public class Part2 :IPart
    {
        public string Run(string input)
        {
            List<int> result = new List<int>();
            foreach (string line in input.Split('\n'))
            {
                List<int> values = new List<int>();

                for (int i = 0; i < line.Length; i++)
                {
                    if (Char.IsNumber(line[i]))
                    {
                        int value = Convert.ToInt32(line[i].ToString());
                        values.Add(value);
                    }
                    switch (line[i])
                    {
                        case 'o':
                            if (line.Length - i >= 2 && line[i + 1] == 'n' && line[i + 2] == 'e')
                                values.Add(1); Console.WriteLine(i.ToString() + ",1");
                            break;
                        case 't':
                            if (line.Length - i >= 2 && line[i + 1] == 'w' && line[i + 2] == 'o')
                            {
                                values.Add(2); Console.WriteLine(i.ToString() + ",2");
                            }
                                
                            if (line.Length - i >= 4 && line[i + 1] == 'h' && line[i + 2] == 'r' && line[i + 3] == 'e' && line[i + 4] == 'e')
                            {
                                values.Add(3); Console.WriteLine(i.ToString() + ",3");
                            }
                            break;
                        case 'f':
                            if (line.Length - i >= 3 && line[i + 1] == 'o' && line[i + 2] == 'u' && line[i + 3] == 'r')
                            {
                                values.Add(4); Console.WriteLine(i.ToString() + ",4");
                            }
                                
                            if (line.Length - i >= 3 && line[i + 1] == 'i' && line[i + 2] == 'v' && line[i + 3] == 'e')
                            {
                                values.Add(5); Console.WriteLine(i.ToString() + ",5");
                            }
                                
                            break;
                        case 's':
                            if (line.Length - i >= 2 &&  line[i + 1] == 'i' && line[i + 2] == 'x')
                            {
                                values.Add(6); Console.WriteLine(i.ToString() + ",6");
                            }
                                
                            if (line.Length - i >= 4 && line[i + 1] == 'e' && line[i + 2] == 'v' && line[i + 3] == 'e' && line[i + 4] == 'n')
                            {
                                values.Add(7); Console.WriteLine(i.ToString() + ",7");
                            }
                                
                            break;
                        case 'e':
                            if (line.Length - i >= 4 && line[i + 1] == 'i' && line[i + 2] == 'g' && line[i + 3] == 'h' && line[i + 4] == 't')
                            {
                                values.Add(8); Console.WriteLine(i.ToString() + ",8");
                            }
                                
                            break;
                        case 'n':
                            if (line.Length - i >= 3 && line[i + 1] == 'i' && line[i + 2] == 'n' && line[i + 3] == 'e')
                            {
                                values.Add(9); Console.WriteLine(i.ToString() + ",9");
                            }
                                
                            break;
                        default:
                            break;

                    }
                }

                result.Add(Convert.ToInt32(values[0].ToString() + values[values.Count - 1].ToString()));
            }
            int sum = 0;
            foreach (int value in result)
            {
                sum += value;
            }
            return sum.ToString();
        }
    }
}
