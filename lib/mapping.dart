import 'package:brew/homepage.dart';
import 'package:brew/register.dart';
import 'package:flutter/material.dart';
import 'login.dart';
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
         if (firebaseUserId!=null){
            authStatus=AuthStatus.signedIn;

         }

        // authStatus= firebaseUserId==null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        
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
  
  void signedOut()
  {
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }

  void _createAccount()
  {
      setState(() {
      authStatus=AuthStatus.register;
    });

  }
  void _haveAccount()
  {
      setState(() {
      authStatus=AuthStatus.notSignedIn;
    });

  }



 

  @override
  Widget build(BuildContext context)
   {
     switch (authStatus) 
     {
      
       case AuthStatus.notSignedIn:
              return new LoginRegisterPage
      (
        auth:widget.auth,
        onSignedIn:_signedIn,
         onCreateAccount:_createAccount,
     
              );
         
       case AuthStatus.signedIn:
            return new HomePage
      (
        auth:widget.auth,
        onSignedOut:signedOut,
              );      
       case AuthStatus.register:
            return new RegisterPage(
              auth:widget.auth,
              onRegisteration: _signedIn,
              onHaveAccount:_haveAccount,
            );
  
     }
          return null;
          }
        
         
  }

