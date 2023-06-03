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
    }

    render(){
        return(
            <div className="from-block3">
                                <p className="section-5__text">Любите ли вы мосты?</p>
                                {this.props.info1.map((e)=>{

                                    return(<InputRad id={e.id} text={e.text} key={e.id}/>)
                                })}
                                <p className="section-5__text">Выберите лучшие мосты:</p>
                                {this.props.info2.map((e)=>{
                                   return (<InputCheck id={e.id} text={e.text} key={e.id}/>)
                                })}
                                <p className="section-5__text">Выберите ваш люимый мост</p>
                                <select id="selectID" className="select-css">
                                {this.props.info2.map((e)=>{
                                    return(<option  key={e.id}>{e.text}</option>)
                                })}   
                                 </select>
                                
                            </div>
                   
        );
    }
}

//Компоненты для контролов
class InputRad extends React.Component{
    constructor(props){
        super(props)
    }
    render(){
        return(
        <div>
            <input type="radio" name="rad" key={this.props.id}/>
            <span>{this.props.text}</span>
        </div>
        );
    } 
}
class InputCheck extends React.Component{
    constructor(props){
        super(props)
    }
    render(){
        return(
        <div>
            <input type="checkbox" name="rad" key={this.props.id} />
            <span>{this.props.text}</span>
        </div>
        );
    } 
}


//основоной компонент
class FormToPage extends React.Component{
    constructor(props){
        super(props);
        
        this.state = {value1:"", value2:"",value3:"",value4:"",valueArea:""};

        this.handleSubmit = this.handleSubmit.bind(this);
        this.getData = this.getData.bind(this);
    }

    //Вывод данных из формы в алерт
    handleSubmit(event){
        alert(
        `
        ФИО: ${this.state.value1},
        Город: ${this.state.value2},
        Телефон: ${this.state.value3},
        E-Mail: ${this.state.value4},
        Сообщение:${this.state.valueArea}`
        );

        event.preventDefault();
    }

    //Получения значения из дочерних элементов 
    getData(val){
       //распаковка объекта, присовение его стейту
        this.setState({...val});
        
    }

    render(){
        return(
            <form onSubmit={this.handleSubmit}>
                <Block1 info={block1Info} sendData={this.getData}/>
                <Block2 info={block2Info} sendData={this.getData}/>
                <Block3 info1={block3Info1} info2={block3Info2}/>
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
