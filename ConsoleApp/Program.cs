using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Json;
using System.Reflection.Metadata;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

class WordItem
{
    public int id { get; set; }
    public string word { get; set; }
    public int count { get; set; }
}

public class Program {
    static async Task Main(string[] args)
    {
        //Получения текста из файла 
        Console.WriteLine("Введите путь до файла с текстом:");
        string filePath = Console.ReadLine();
        string text = File.ReadAllText(filePath);

        //Создание HttpClient
        HttpClient client = new HttpClient();
        
        //Помещения текста в json
        var data = new { text = $"{text}" };
        var jsonPost = JsonConvert.SerializeObject(data);

        //отпрака POST запроса 
        var content = new StringContent(jsonPost, Encoding.UTF8, "application/json");
        var responsePost = await client.PostAsync("https://localhost:7042/api/Word", content);

        if (responsePost.IsSuccessStatusCode)
        {
            Console.WriteLine("Запрос POST выполнен успешно!");
        }
        else
        {
            Console.WriteLine("Произошла ошибка при выполнении запроса POST: " + responsePost.StatusCode);
        }

        //Получения обработанного текста в json и запись его в словарь 
        HttpResponseMessage responseGet = await client.GetAsync("https://localhost:7042/api/Word");
        if (responseGet.IsSuccessStatusCode)
        {
            string json = await responseGet.Content.ReadAsStringAsync();
            List<WordItem> items = JsonConvert.DeserializeObject<List<WordItem>>(json);
            Dictionary<string, int> wordCountDictionary = new Dictionary<string, int>();
            foreach (WordItem item in items)
            {
                
                string word = item.word;
                int count = item.count;

                wordCountDictionary[word] = count;
                
          }
            foreach (var kvp in wordCountDictionary)
            {
                Console.WriteLine($"{kvp.Key}: {kvp.Value}");
            }

            // Очистка API
            var responseDelete = await client.DeleteAsync("https://localhost:7042/api/Word");

            string outputFilePath = Path.GetDirectoryName(filePath) + "/UniqueWords.txt";
            using (StreamWriter sw = new StreamWriter(outputFilePath))
            {
                foreach (var word in wordCountDictionary)
                {
                    sw.WriteLine($"{word.Key}: {word.Value}");
                }
            }

            Console.WriteLine($"Файл, с уникальными словами сохранен по пути {outputFilePath}");





        }


    }
    
}