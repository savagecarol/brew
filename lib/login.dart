
import 'package:brew/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentication.dart';
import 'dialogbox.dart';


// enum FormType
// {
//   Login,
//   Register
// }



class LoginRegisterPage extends StatefulWidget
 { 
   LoginRegisterPage({
this.auth,
this.onSignedIn,
this.onCreateAccount


   });
    final AuthImplementation auth;
  final VoidCallback onSignedIn;
  final VoidCallback onCreateAccount;


  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();


}

class _LoginRegisterPageState extends State<LoginRegisterPage> 
{
  

DialogBox dialogBox=new DialogBox();

 final formKey=new GlobalKey<FormState>();

// FormType _formType=FormType.Login;

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
       String userId=await widget.auth.signIn(_email,_password);
        print("$userId");
         
          widget.onSignedIn();
     }
    
      catch(e)
      {
        dialogBox.information(context, "Error", e.toString());
        print("Error =" +e.toString());
      }
    
   }
 }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
       resizeToAvoidBottomPadding: false,

        appBar: new AppBar(
           backgroundColor: Colors.white70,
          elevation: 100,      
          automaticallyImplyLeading: false,
            title:Padding(
              padding: const EdgeInsets.only(top:15,bottom: 15),
                          child: new Center(child:new Text("Brew",
          style:GoogleFonts.dancingScript(
              fontSize: 30,
              color: Colors.grey[700],
              fontStyle:FontStyle.normal,
              fontWeight: FontWeight.bold,)),
         
        ),
            ),
        ),
        body: new Container(
          padding: const EdgeInsets.only(top:40,bottom:40,right: 50,left: 50,),
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
    
     Center(child:new Text("Login Page", style:GoogleFonts.poiretOne(

              fontSize: 30,
              color: Colors.grey[700],
              fontStyle:FontStyle.normal,
              fontWeight: FontWeight.bold,)),
     ),
    SizedBox(height: 25),
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
        hintText:'Password',),
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
          backgroundColor: Colors.grey,
          radius:100,
          child:CircleAvatar(
            radius:95,
          backgroundImage:AssetImage('assets/a.jpg'),
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
        color: Colors.white70,
        child:new Text("Login", style:GoogleFonts.poiretOne(
              fontSize: 26,
              color: Colors.grey[700],
              fontStyle:FontStyle.normal,
              fontWeight: FontWeight.bold,)
        ),
        onPressed: validateAndSubmit,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide.none),
                elevation: 10,
                ),
            ),
            Padding(padding: const EdgeInsets.only(top:7)),
              new FlatButton(onPressed:(){ 
               widget.onCreateAccount();
                            },
                            child:new Text("Create An Account", style:GoogleFonts.lato(
              fontSize: 16,
              color: Colors.grey[700],
              fontStyle:FontStyle.normal,
              fontWeight: FontWeight.bold,))),
                        ];
  

  }

                      
                    
}

//  Navigator.of(context).push
                  // (new MaterialPageRoute(builder:(BuildContext context)=> RegisterPage()));

