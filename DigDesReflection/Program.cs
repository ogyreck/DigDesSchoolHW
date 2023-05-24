using System.Reflection;

namespace DigDesReflection
{
    class Program
    {
        static void Main(string[] args)
        {
            // Путь до файла с текстом 
            Console.WriteLine("Введите путь до файла с текстом:");
            string filePath = Console.ReadLine();
            string textFile = File.ReadAllText(filePath);

            TextCounter.TextCounter tc = new TextCounter.TextCounter();

            var type = typeof(TextCounter.TextCounter);

      
            MethodInfo infromMethod = type.GetMethod("counterTextUnqWords", BindingFlags.NonPublic | BindingFlags.Instance);

            object obj = new object();
            obj = textFile;

            var result = (Dictionary<string, int>)infromMethod.Invoke(tc, new object[] {obj});

            string outputFilePath = Path.GetDirectoryName(filePath) + "/UniqueWords.txt";
            using (StreamWriter sw = new StreamWriter(outputFilePath))
            {
                foreach (var word in result)
                {
                    sw.WriteLine($"{word.Key}: {word.Value}");
                }
            }

            Console.WriteLine($"Файл, с уникальными словами сохранен по пути {outputFilePath}");





        }
    }
}