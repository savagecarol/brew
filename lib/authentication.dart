import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthImplementation
  {
 Future<String> signIn(String email,String password);
  Future<String> signUp(String email,String password);
   Future<String> getCurrentuser();
    Future<String> signOut();

  } 

class Auth implements AuthImplementation
  {
    final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  Future<String> signIn(String email,String password)async
  {
  AuthResult authResult=await _firebaseAuth.signInWithEmailAndPassword(email: email , password: password);
        FirebaseUser user=authResult.user;
        return user.uid;  
    }

    Future<String> signUp(String email,String password)async
  {
    AuthResult authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email , password: password);
    FirebaseUser user=authResult.user;
    return user.uid;
  }         
      Future<String> getCurrentuser() async
        {
          FirebaseUser user=await _firebaseAuth.currentUser();
                      return user.uid;
            }
        Future<String> signOut() async
            {
                _firebaseAuth.signOut();
          }



}
