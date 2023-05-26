using System.Reflection;
using System.Diagnostics;
using TextCounter;
using static System.Net.Mime.MediaTypeNames;


namespace Multitrhead
{
   
        class Program
        {
            static void Main(string[] args)
            {
            // Путь до файла с текстом 
            Console.WriteLine("Введите путь до файла с текстом:");
            string filePath = Console.ReadLine();
            string textFile = File.ReadAllText(filePath);

            TextCounter.TextCounter1 tc = new TextCounter.TextCounter1();
            Stopwatch stopwatch = new Stopwatch();

            var type = typeof(TextCounter.TextCounter1);
            MethodInfo infromMethod = type.GetMethod("counterTextUnqWords", BindingFlags.NonPublic | BindingFlags.Instance);

            object obj = new object();
            obj = textFile;


            //Замерка времени дле приватного не многопоточного метода
            stopwatch.Start();
            var result = (Dictionary<string, int>)infromMethod.Invoke(tc, new object[] { obj });
            stopwatch.Stop();
            TimeSpan privateMethodTime = stopwatch.Elapsed;

            stopwatch.Reset();
            stopwatch.Start();
            tc.ProcessTextMultithreaded(textFile); // Замените на вызов вашего публичного метода
            stopwatch.Stop();
            TimeSpan publicMethodTime = stopwatch.Elapsed;

            // Вывод результатов
            Console.WriteLine("Время выполнения приватного метода: " + privateMethodTime);
            Console.WriteLine("Время выполнения публичного метода с многопоточностью: " + publicMethodTime);

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
