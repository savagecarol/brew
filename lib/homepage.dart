import 'package:brew/photoupload.dart';
import 'package:brew/scratchcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authentication.dart';
import 'Posts.dart';
import 'package:firebase_database/firebase_database.dart';
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
    
  List<Posts> postList =[];
  @override
  void initState()
  {
      DatabaseReference postsRef=FirebaseDatabase.instance.reference().child("Posts");
      postsRef.once().then((DataSnapshot snap){
var KEYS=snap.value.keys;
var DATA=snap.value;
        postList.clear();
            for(var i in KEYS)
            {
              Posts posts= new Posts
              (

              DATA[i]['date'],
              DATA[i]['description'],
              DATA[i]['image'],
              DATA[i]['time'],

              );
              postList.add(posts);
            }
            setState(() {
              print('Lengh:$postList.length');
            });
      }); 
  
  }

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
      resizeToAvoidBottomPadding: false,
         appBar: new AppBar(
           automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey,
            elevation: 120,
              title:Column(
                children: <Widget>[
                  new Text("Blogs", style:GoogleFonts.lobster(
                  fontSize: 35,
                  color: Colors.white,
                  fontStyle:FontStyle.normal,
                  fontWeight: FontWeight.bold,)),
                  Padding(padding: EdgeInsets.only(top:5))
                ],
              ),
                  centerTitle: true,
                  
         ),

      body:new Container(

        child: postList.length==0 ? Center(child: new Text("No Blog Available",style:GoogleFonts.badScript(
                  fontSize: 20,
                  color: Colors.black,
                  fontStyle:FontStyle.normal,
                  fontWeight: FontWeight.bold,))):
                new ListView.builder(itemCount:postList.length,
                itemBuilder: (_,index){
                  return PostsUI(postList[index].date,
                  postList[index].description,
                  postList[index].image,
                  postList[index].time, );
                }
      
      
              )


      ),

      bottomNavigationBar: new BottomAppBar(
      color: Colors.grey[200],
      elevation: 50,
        child: new Container(
          margin:const EdgeInsets.only(left:50,right:50),
          child:new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon:Icon(Icons.lightbulb_outline),
                iconSize: 30,color:Colors.black54  ,
                onPressed:(){
                  Navigator.push
                  (context,
                  MaterialPageRoute(builder: (context)
                  {
                    return new ScratchPage();
                  })
                  );
                 } ),
                  new IconButton(
                icon:Icon(Icons.add),
                iconSize: 30,color:Colors.black54  ,
                onPressed:(){
                  Navigator.push
                  (context,
                  MaterialPageRoute(builder: (context)
                  {
                    return new Uploadpage();
                  })
                  );
                } ),
                  new IconButton(
                icon:Icon(Icons.arrow_forward_ios),
                iconSize: 25,color:Colors.black54  ,
                onPressed:_logoutUser )
            ],
    
          )
        ),
      ),
    );
  }

Widget PostsUI(String date,String description,String image,String time)
{
return new Card
(
  elevation: 120,
  margin: EdgeInsets.only(top:15.0,left:15,right:15),
  child: new Container(
    padding: new EdgeInsets.only(top:14.0,left: 14,right:14),
    child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  new Text
                (
                  date,style:GoogleFonts.benchNine(
                  fontSize: 20,
                  color: Colors.grey[900],
                  fontStyle:FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                  new Text
                (
                  time,style:GoogleFonts.benchNine(
                  fontSize: 20,
                  color: Colors.grey[900],
                  fontStyle:FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                )
                ]
              ),

              SizedBox(height: 10,),
              new Image.network(image,fit:BoxFit.cover),
               SizedBox(height: 10,),
                    Center(
                      child: new Text
                (
                  description,style:GoogleFonts.neucha(
                  fontSize: 18,
                  color: Colors.grey[1000],
                  fontStyle:FontStyle.normal,
                  fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                    )             

              ],      
    ),
  ),
);

}


}