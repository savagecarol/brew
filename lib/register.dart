import 'package:flutter/material.dart';
import 'authentication.dart';
import 'login.dart';



class RegisterPage extends StatefulWidget
 { 
RegisterPage({
this.auth,
this.onRegisteration,
this.onHaveAccount,
   });
    final AuthImplementation auth;
   final VoidCallback onRegisteration;
   final VoidCallback onHaveAccount;



  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> 
{



 final formKey=new GlobalKey<FormState>();



 String _email="";
 String _password="";

 bool validateAndSave()
  {

  final form =formKey.currentState;
    if(form.validate())
    {
     form.save();
     return true ;
    }
    else
    {
      return false;
    }
 }

  void validateAndSubmit() async
 {
   if(validateAndSave())
   {
     try
     {
       String userId=await widget.auth.signUp(_email,_password);
       print("$userId");
     }
      catch(e)
      {
        print("Error =" +e.toString());
      }
      widget.onRegisteration();
   }
 }




  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
       resizeToAvoidBottomPadding: false,

        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title:new Center(child:new Text("Brew")),
        ),
        body: new Container(
          padding: const EdgeInsets.only(top:30,bottom:40,right: 50,left: 50,),
          margin: EdgeInsets.all(15.0),
          child:new Form
          (
              key:formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs()+createButtons()

            ),
          ),
        ),

    );
  }

List<Widget> createInputs()
{
  return
  [
    
     Center(child:new Text("Register Page",style:new TextStyle(fontSize: 40.0,color: Colors.black)),),
    SizedBox(height: 20),
    logo(),
    SizedBox(height: 10.0),
    new TextFormField
    (keyboardType:TextInputType.text,
      decoration: new InputDecoration(
        hintText:'Email'),
     validator: (value)
     {
        return value.isEmpty ? 'Email is required.': null; 
     },   
         onSaved: (value)
     {
       return _email=value;
     },
      ),
       new TextFormField
    (
      keyboardType:TextInputType.text,
      obscureText: true,
      decoration: new InputDecoration(
        hintText:'Password'),
           validator: (value)
     {
        return value.isEmpty ? 'Password is required.': null; 
     },
     onSaved: (value)
     {
       return _password=value;
     },
      ),
    Padding(padding:const EdgeInsets.only(top:15))
  ];
}

Widget logo()
{
  return Center(
    child: new Hero
    (
      tag:'hero',
        child:new CircleAvatar(
          backgroundColor: Colors.pink,
          radius:100,
          child:CircleAvatar(
            radius:95,
          backgroundImage:NetworkImage('https://png.pngtree.com/png-clipart/20190922/original/pngtree-colorful-watercolor-frame-hologram-paint-splash-png-image_4769868.jpg'),
          ),
        
        ),
        
    ),
  );

}

List<Widget> createButtons()
{
 
  
      return 
  [
    Padding(
      padding: const EdgeInsets.only(right:60,left:60),
      child: new RaisedButton(
        color: Colors.black12,
        child:new Text("register ",style:new TextStyle(fontSize: 20.0,color: Colors.white)),
        onPressed: validateAndSubmit,
                elevation: 10,
                ),
            ),
              new FlatButton(onPressed:(){ 
                     Navigator.of(context).push
                  (new MaterialPageRoute(builder:(BuildContext context)=> LoginRegisterPage()));},
                            child:new Text("Have An Account",style:new TextStyle(fontSize: 14.0))),
                        ];
  

  }

                      
                    
}


