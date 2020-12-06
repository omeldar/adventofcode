using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AoC.Foundation
{
    public static class IntegerHelper
    {
        public static int GetHighestValue(this int[] dataArray)
        {
            int highest = 0;
            foreach(int _value in dataArray)
            {
                if (_value == dataArray[0])
                    highest = _value;

                if (highest < _value)
                    highest = _value;
            }

            return highest;
        }

        public static int GetLowestValue(this int[] dataArray)
        {
            int lowest = 0;
            foreach (int _value in dataArray)
            {
                if (_value == dataArray[0])
                    lowest = _value;

                if (lowest > _value)
                    lowest = _value;
            }

            return lowest;
        }
    }
}
