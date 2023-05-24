using System.Text.RegularExpressions;

namespace TextCounter
{
    public class TextCounter
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
    }
}