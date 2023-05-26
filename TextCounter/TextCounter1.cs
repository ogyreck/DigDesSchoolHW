using System.Collections.Concurrent;
using System.Text.RegularExpressions;

namespace TextCounter
{
    public class TextCounter1
    {

        private Dictionary<string, int> counterTextUnqWords(string textFile)
        {

            Dictionary<string, int> uniqueWords = new Dictionary<string, int>();

            string line = textFile.ToLower();
            string[] words = Regex.Split(line, @"(?=[\p{P}\s\d])[^’]");
            foreach (string word in words)

            {
                if (!string.IsNullOrEmpty(word))
                {
                    if (uniqueWords.ContainsKey(word))
                    {
                        uniqueWords[word]++;
                    }

                    else
                    {
                        uniqueWords.Add(word, 1);
                    }

                }
            }


            //Сортируем слова по убыванию количества употреблений и записываем в выходной файл
            var sortedWords = uniqueWords.OrderByDescending(x => x.Value).ToDictionary(x => x.Key, x => x.Value);
            return sortedWords;
        }



        

        // Публичный метод с многопоточной обработкой текста
        public Dictionary<string, int> ProcessTextMultithreaded(string text)
        {

            Dictionary<string, int> uniqueWords = new Dictionary<string, int>();

            List<Dictionary<string, int>> listDict = new List<Dictionary<string, int>>();
            // Создание конкурентной очереди для хранения частей текста
            ConcurrentQueue<string> textQueue = new ConcurrentQueue<string>();

            // Разделение текста на части и добавление их в очередь
            string[] textParts = SplitTextIntoParts(text, Environment.ProcessorCount);
            foreach (string part in textParts)
            {
                textQueue.Enqueue(part);
            }

            // Многопоточная обработка текста
            Parallel.ForEach(textQueue, part =>
            {
                Dictionary<string, int> addDiction = counterTextUnqWords(part);
                lock (addDiction)
                {
                    listDict.Add(addDiction);
                }
            });


            // Соеденяем словари в один 
            foreach (Dictionary<string, int> dictionary in listDict)
            {
                foreach (KeyValuePair<string, int> kvp in dictionary)
                {
                    if (uniqueWords.TryGetValue(kvp.Key, out int existingValue))
                    {

                        int sumValue = existingValue + kvp.Value;
                        uniqueWords[kvp.Key] = sumValue;
                    }
                    else
                    {
                        // Ключ отсутствует, просто добавляем пару ключ-значение
                        uniqueWords.Add(kvp.Key, kvp.Value);
                    }
                }
            }
            return uniqueWords.OrderByDescending(x => x.Value).ToDictionary(x => x.Key, x => x.Value);
        }

        // Вспомогательный метод для разделения текста на части
        private string[] SplitTextIntoParts(string text, int numParts)
        {
            int partLength = text.Length / numParts;
            string[] parts = new string[numParts];

            for (int i = 0; i < numParts; i++)
            {
                int startIndex = i * partLength;
                int endIndex = (i == numParts - 1) ? text.Length : (i + 1) * partLength;
                parts[i] = text.Substring(startIndex, endIndex - startIndex);
            }

            return parts;
        }
    }
}