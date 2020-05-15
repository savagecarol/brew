import 'package:brew/homepage.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import'register.dart';
import 'authentication.dart';

class MappingPage extends StatefulWidget {
final AuthImplementation auth;
MappingPage({
  this.auth
});

  @override
  _MappingPageState createState() => _MappingPageState();
}
enum AuthStatus
{
  notSignedIn,
  signedIn,
  register,
}

class _MappingPageState extends State<MappingPage> {


AuthStatus authStatus=AuthStatus.notSignedIn;

  


@override
void initState() {
   
    super.initState();
    widget.auth.getCurrentuser().then((firebaseUserId)
    {
      setState(() {
      
        {
        authStatus= firebaseUserId==null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        } 
    
      });
    });
  }


  void _signedIn()
  {
    setState(() {
      authStatus=AuthStatus.signedIn;
    });
  }
  
  void _signedOut()
  {
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }
    void _registeration()
  {
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }

 

  @override
  Widget build(BuildContext context)
   {
     switch (authStatus) {
      
       case AuthStatus.notSignedIn:
              return new LoginRegisterPage
      (
        auth:widget.auth,
        onSignedIn:_signedIn,
     
              );
         
       case AuthStatus.signedIn:
            return new HomePage
      (
        auth:widget.auth,
        onSignedOut:_signedOut,
              );      
  
       case AuthStatus.register:
            return new RegisterPage
            (
        auth:widget.auth,
        onRegisteration:_registeration,

              );
      
     }
          return null;
          }
        
         
  }

