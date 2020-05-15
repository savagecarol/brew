import 'package:flutter/material.dart';
import 'authentication.dart';
class HomePage extends StatefulWidget {
     HomePage({
this.auth,
this.onSignedOut

   });
    final AuthImplementation auth;
  final VoidCallback onSignedOut;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

void _logoutUser() async 
{
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }
    catch(e)
    {
      print("Error =" + e.toString());
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title:new Center(child: Text("Home")),
      ),

      body:new Container(),

      bottomNavigationBar: new BottomAppBar(
      color: Colors.pink,
        child: new Container(
          margin:const EdgeInsets.only(left:50,right:50),
          child:new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon:Icon(Icons.local_car_wash),
                iconSize: 35,color:Colors.white  ,
                onPressed: _logoutUser),
                  new IconButton(
                icon:Icon(Icons.add_a_photo),
                iconSize: 35,color:Colors.white  ,
                onPressed:null ),
                  new IconButton(
                icon:Icon(Icons.settings),
                iconSize: 35,color:Colors.white  ,
                onPressed:null )
            ],
    
          )
        ),
      ),
    );
  }
}