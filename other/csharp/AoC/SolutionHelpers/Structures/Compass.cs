using AoC.SolutionHelpers.Enumerators;

namespace AoC.SolutionHelpers.Structures
{
    public class Compass<T>
    {
        /// <summary>
        /// Values in Compass
        /// </summary>
        public T[] Values { get; set; }

        /// <summary>
        /// Current Index of Compass
        /// </summary>
        public int Index { get; set; }

        /// <summary>
        /// Create a compass and assign values to directions
        /// </summary>
        /// <param name="values"></param>
        public Compass(T[] values) { Values = values; }

        /// <summary>
        /// Movas compass into a direction and returns the value of this direction
        /// </summary>
        /// <param name="moveTo">The direction to move to</param>
        /// <returns>The value of that direction</returns>
        public T MoveAndGet(Direction moveTo)
        {
            switch (moveTo)
            {
                case Direction.Left:
                    if (Index == 0)
                        Index = Values.Length - 1;
                    else
                        Index -= 1;
                    break;
                case Direction.Right:
                    if (Index == Values.Length -1)
                        Index = 0;
                    else
                        Index += 1;
                    break;
                default:
                    break;
            }
            return Values[Index];
        }
    }
}
