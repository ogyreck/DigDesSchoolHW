const spaceToPast = document.querySelector('.section-6_api-info');
const btn = document.querySelector("#button-api");
const textToHide = spaceToPast.querySelector(".section-4__text")
console.log(spaceToPast);
let data = null;

const userAction = async () => {
    const response = await fetch('https://fakestoreapi.com/products');
    const myJson = await response.json();
    
    
    
    myJson.forEach((e)=>{
        addDataToSite(e);

    })
    console.log('ок')
    
    
}

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



btn.addEventListener('click',  ()=>{
    textToHide.style.display = "none";
    setTimeout(userAction,1000)});

console.log(data);


