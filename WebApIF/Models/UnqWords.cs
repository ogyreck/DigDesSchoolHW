namespace WebApIF.Models
{

    //Модель для слов
    public class UnqWords
    {

        public int id { get; set; }
        public string word { get; set; }

        public int count { get; set; }
    }

    // Модель для отправки текста 
    public class Text
    {
        public string text { get; set; }    
    }
}
