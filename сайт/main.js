const spaceToPast = document.querySelector('.section-6_api-info');
const btn = document.querySelector("#button-api");
const textToHide = spaceToPast.querySelector(".section-4__text")

//функция выозва api и обработка данных
const userAction = async () => {
    const response = await fetch('https://fakestoreapi.com/products');
    const myJson = await response.json();

    myJson.forEach((e)=>{
        addDataToSite(e);
    })
 
}

//функция для добавления данных на страницу 
function addDataToSite(json){
    
    const htmlCode = `<div class="api_card">
            <p class="api_card-name section-4__content-block1-title">${json.title}</p>
            <img src="${json.image}">
            <p class="api_card_info ">${json.description}</p>
        </div>`;
    let div = document.createElement('div');
    div.innerHTML = htmlCode;
    spaceToPast.append(div);
}

//отработчик событий с кнопки 
btn.addEventListener('click',  ()=>{
    textToHide.style.display = "none";
    setTimeout(userAction,1000)
});




