  import 'package:brew/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as  http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';

class ScratchPage extends StatefulWidget
{
    @override
    _ScratchPageState createState()=> new _ScratchPageState();

}

class _ScratchPageState extends State<ScratchPage>
{
   

      Future<Null> refreshList() async{
        await Future.delayed(Duration(seconds: 2));
        setState(() {
        });
        return null;
    }
  @override 
  Widget build(BuildContext context)
  {
     return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.blueGrey,
            elevation: 120,
              title:Column(
                children: <Widget>[
                  new Text("Quotes", style:GoogleFonts.lobster(
                  fontSize: 38,
                  color: Colors.white,
                  fontStyle:FontStyle.normal,
                  fontWeight: FontWeight.bold,)),
                  Padding(padding: EdgeInsets.only(top:5))
                ],
              ),
                  centerTitle: true,
                  
         ),
          
                body: RefreshIndicator(
                backgroundColor: Colors.grey[700],
                onRefresh: refreshList,
              child: ListView.builder(itemCount: 1,
                  itemBuilder: (context,i)=>
                   Container(
                    padding: const EdgeInsets.only(top:20,bottom:100,left:80,right: 80),
                  child: Column(
                    children: <Widget>[
                      FutureBuilder
                          (
                          future: motivation(),
                          builder: (BuildContext context, AsyncSnapshot snapshot)
                          {
                              if (snapshot.data == null)
                              {
                                  return Container(
                                      padding: const EdgeInsets.only(top:150,bottom:100,left:80,right: 80),
                                    child: SpinKitRing(
                                        size: 40,
                                        color: Colors.white,
                                    ),
                                  );
                              }
                              else
                              {
             return hy( "${snapshot.data[i].line}", "${snapshot.data[i].name}",);
                                  }
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          );
  }

   Center hy(String s,String p)
{
  if(p=="null")
  {
    p="unknown";
  }
    return Center(
      child: Column(
          children: <Widget>[
              Padding(padding: const EdgeInsets.only(bottom:50,left:80,right: 80,top:30 ),),
          Text(
          s,
          style:GoogleFonts.cookie(fontSize: 32,fontStyle:FontStyle.normal,fontWeight: FontWeight.w500),
          ),
           Padding(padding: const EdgeInsets.only(top:8),),
            Text(
          "-$p",
          textAlign: TextAlign.end,
          style:GoogleFonts.cookie(fontSize: 35,fontStyle:FontStyle.normal,fontWeight: FontWeight.w500,),
          ),

          ],

          ),
    );
}

  }


var random=new Random();


 Future<List<MotivationalQuote>>  motivation ()
async {
    int i;
     i=random.nextInt(1643);
    var data = await http.get(
        "https://type.fit/api/quotes");
    var jsonData = json.decode(data.body);
    String line=  jsonData[i]['text'];
    String name=jsonData[i]['author'];
print("$line");
print('$name');
      List<MotivationalQuote> quote = [];  
    MotivationalQuote ls = MotivationalQuote
       (
         line ,
        name ,
      );
     quote.add(ls);
    return quote;
    }

    class MotivationalQuote {
  String line;
  String name;
  MotivationalQuote(this.line, this.name);

}



