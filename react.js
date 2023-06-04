'use strict';

//Информация для создания элементов
let block1Info = [{id: 1, text: 'ФИО'},{id:2, text: 'Город'}]
let block2Info = [{id:1,text:'Телефон'}, {id:2, text:"E-mail"}]
let block3Info1 = [{id:1,text:'Да'},{id:2,text:'Нет'}]
let block3Info2 = [{id:1,text:'Дворцовый мост'},{id:2,text:'Литейный мост'},{id:3,text:'Банковский мост'}]

class Block1 extends React.Component{
    constructor(props){
        super(props)
        this.state = { value1 : "", 
                        value2: ""};
        this.handleChange = this.handleChange.bind(this);
    }

    //Сохраниние текущего состояния формы в стейт компоненты, и отправка его в родительский компонент
    handleChange(event){
        let id = event.target.placeholder == "ФИО"? 1:2;
        this.setState({ ["value"+id]: event.target.value });
        this.props.sendData(this.state);	
    }
    

    render(){
        return(
            <div className="form-block1">
                {this.props.info.map((e)=>{
                    return(<input type="text" placeholder={e.text} required className="input i-1" key={e.id} value={this.state[`value`+e.id]} onChange={this.handleChange}></input>)
                })} 
            </div>
                   
        );
    }
}


class Block2 extends React.Component{
    constructor(props){
        super(props)

        this.state = { value3 : "", 
                        value4: "",
                        valueArea:""};
        this.handleChange = this.handleChange.bind(this);
        this.textAreaChange = this.textAreaChange.bind(this);
    }

    //Сохраниние текущего состояния формы в стейт компоненты, и отправка его в родительский компонент 
    handleChange(event){
        let id = event.target.placeholder == "Телефон"? 3:4;
        this.setState({ ["value"+id]: event.target.value });
        this.props.sendData(this.state);	
    }
    //тоже саммое что и функция выше, но для textArea
    textAreaChange(event){
        this.setState({ valueArea: event.target.value });
        this.props.sendData(this.state);
    }

    render(){
        return(
            <div className="form-block2">
                <div className="form-block2-1">
                {this.props.info.map((e)=>{
                    
                    return (<input type="text" placeholder={e.text} required className="input" key={e.id}  value={this.state[`value`+e.id]} onChange={this.handleChange}/>)
                })} 
                </div>
                <textarea name="messege" id="messege" cols="30" rows="10" placeholder="Сообщение"className="input i-5" value={this.state.valueArea} onChange={this.textAreaChange}></textarea>
            </div>
                   
        );
    }
}

class Block3 extends React.Component{
    constructor(props){
        super(props)

        this.state = {likeValue: "",
            checkBox :[],
            option: ""

        
    };
        this.handleChange = this.handleChange.bind(this);
        this.chekBoxCheker = this.chekBoxCheker.bind(this);
        this.optionCheck = this.optionCheck.bind(this);
    }

    handleChange(event){
        this.setState({likeValue:event.target.value})
        this.props.sendData(this.state);
    }

    chekBoxCheker(event){
        const value = event.target.value;
        const check = event.target.checked;
        
        this.setState((prevState)=>{
            if(check){
                return{
                    checkBox: [...prevState.checkBox, value]
                };
            }
            else{
                return{
                    checkBox: prevState.checkBox.filter( val => val!==value)
                }
            }
        });

        this.props.sendData(this.state);

        

    }
    optionCheck(event){
       this.setState((prevState) =>  {return{ option:event.target.value}})
       this.setState((prevState) =>  {this.props.sendData(prevState);})
       
    }

    




    render(){
        return(
            <div className="from-block3">
                                <p className="section-5__tex">Любите ли вы мосты?</p>
                                <div onChange={this.handleChange}>
                                    <input type="radio" value="Да" name="like"/> Да<br/>
                                    <input type="radio" value="Нет" name="like"/> Нет
                                </div>
                                <p className="section-5__text">Выберите лучшие мосты:</p>
                                <div onChange={this.chekBoxCheker}>
                                     <input type="checkbox" name="rad"  value ="Дворцовый мост"/>Дворцовый мост<br/>
                                     <input type="checkbox" name="rad"  value ="Литейный мост"/>Литейный мост<br/>
                                     <input type="checkbox" name="rad"  value ="Банковский мост"/>Банковский мост<br/>
                                </div>
                                
                                <p className="section-5__text">Выберите ваш любимый мост</p>
                                <select id="selectID" className="select-css" onChange={this.optionCheck}>
                                    <option value = "Не выбрано">Не выбрано</option>
                                    <option  value ="Дворцовый мост">Дворцовый мост</option>
                                    <option value ="Литейный мост">Литейный мост</option>
                                    <option value ="Банковский мост">Банковский мост</option>
                                </select>  
                                 
                                
                            </div>
                   
        );
    }
}



class InputRad extends React.Component{
    constructor(props){
        super(props)

        this.state = {value:""};
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange(event){
        
        this.setState({ value: event.target });
        this.props.sendData(this.state);
        
    }
    render(){
        return(
            <div>
            <input type="radio" name="rad" key={props.id} onChange={this.handleChange}/>
            <span>{props.text}</span>
        </div>
        );
    }

}

//Компоненты для контролов



const InputCheck = (props) =>{
    return(
        <div>
            <input type="checkbox" name="rad" key={props.id} />
            <span>{props.text}</span>
        </div>
        );
}



//основоной компонент
class FormToPage extends React.Component{
    constructor(props){
        super(props);
        
        this.state = {value1:"", value2:"",value3:"",value4:"",valueArea:"",likeValue: "",
        checkBox :[],
        option: "", def:""};

        this.handleSubmit = this.handleSubmit.bind(this);
        this.getData = this.getData.bind(this);
    }

    //Вывод данных из формы в алерт
    handleSubmit(event){
        this.setState((state)=>{
            console.log(state)
        })
        
        alert(
        `
        ФИО: ${this.state.value1},
        Город: ${this.state.value2},
        Телефон: ${this.state.value3},
        E-Mail: ${this.state.value4},
        Сообщение:${this.state.valueArea},
        Любите ли вы мосты: ${this.state.likeValue},
        Лучшие мосты: ${this.state.checkBox.join(", ")},
        Ваш любимый мост: ${this.state.option}
       

        `
        
        );

        event.preventDefault();
    }

    //Получения значения из дочерних элементов 
    getData(val){
       
       //распаковка объекта, присовение его стейту
        this.setState((state)=>{
            return{...state,...val}
        });
        
    }

    render(){
        return(
            <form onSubmit={this.handleSubmit}>
                <Block1 info={block1Info} sendData={this.getData}/>
                <Block2 info={block2Info} sendData={this.getData}/>
                <Block3 info1={block3Info1} info2={block3Info2} sendData={this.getData}/>
                <div className="end-form">
                    <p>Нажимая кнопку «Отправить», даю согласие на обработку персональных данных, указанных <a className="polit">Политики конфиденциальности</a></p>
                    <input type="submit" value="Отправить" name='submit'/>
                </div>
            </form>
        );
    }
}


//Рендр основоного компонента
ReactDOM.render(<FormToPage/>, document.getElementById('root'));
