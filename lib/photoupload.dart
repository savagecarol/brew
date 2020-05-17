import 'package:brew/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Uploadpage extends StatefulWidget {

  @override
  _UploadpageState createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage> {
  
  File sampleImage;
  String _myValue;
  String url;


final formKey =new GlobalKey<FormState>();


  Future getImage() async
  { 
    var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage=tempImage;
    });
  }


bool validateAndSave()
{
  final form=formKey.currentState;
  if(form.validate())
  {
    form.save();
    return true;
  }
  else
  {
    return false;
  }
}
 void saveToDatabase(url)
 {
      var dbTimeKey=new DateTime.now();
      var formatDate=new DateFormat('MMM d,yyyy');
      var formatTime=new DateFormat('EEEE, hh:mm aaa');

      String date=formatDate.format(dbTimeKey);
      String time=formatTime.format(dbTimeKey);
      DatabaseReference ref=FirebaseDatabase.instance.reference();
      var data= 
      {
          "image": url,
          "description":_myValue,
          "date":date,
          "time":time,
      };
      ref.child("Posts").push().set(data);

 } 


Future<void> uploadStatusImage()
async {
  if(validateAndSave())
  {
    final StorageReference postImageRef =FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask =postImageRef.child(timeKey.toString()+ ".jpg").putFile(sampleImage);
      var ImageUrl=await (await uploadTask.onComplete).ref.getDownloadURL();

      url=ImageUrl.toString();
      print("Image Url=" +url);
      goToHomePage();
      saveToDatabase2(saveToDatabase);

  }

}

void goToHomePage()
{
  Navigator.push
  (context,
  MaterialPageRoute(builder:(context)
  {
    return new HomePage();
  }));
}

void saveToDatabase2(void saveToDatabase(dynamic url)) => saveToDatabase(url);
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      resizeToAvoidBottomPadding: false,
     appBar: new AppBar(
      
            backgroundColor: Colors.blueGrey,
            elevation: 10,
              title:Column(
                children: <Widget>[
                  new Text("Upload", style:GoogleFonts.lobster(
                  fontSize: 35,
                  color: Colors.white,
                  fontStyle:FontStyle.normal,
                  fontWeight: FontWeight.bold,)),
                  Padding(padding: EdgeInsets.only(top:5))
                ],
              ),
                  centerTitle: true,
                  
         ),

      body:SingleChildScrollView(
              child: new Container(
         
          child:sampleImage ==null? Container(
    padding: EdgeInsets.symmetric(vertical:300,horizontal:120),
            child: Center(
              child: Text("Select an Image", style:GoogleFonts.badScript(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle:FontStyle.normal,
                        fontWeight: FontWeight.bold,),),
            ),
          ):enableUpload(),
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: getImage,
      tooltip:'Add Image',
      child:new Icon(Icons.add_a_photo),backgroundColor:Colors.blueGrey,),
    );
  }
Widget enableUpload()
{
  return Container(
    padding: EdgeInsets.all(8),
    child: new Form
    (
      key:formKey,
      child:Column
      (
        children:<Widget>
        [
          SizedBox(height:10.0),
          Container(padding:EdgeInsets.only(left:8,right:8),child: Image.file(sampleImage ,height:330,width: 630,),
          color: Colors.grey,height: 300,width:632),
          SizedBox(height:10.0),
          TextFormField(
             keyboardType: TextInputType.multiline,
              maxLines: null,
            decoration: new InputDecoration(hintText:'Caption'),
              validator:(value){
                return value.isEmpty? 'caption is required':null;
        
              } ,
                      onSaved:(value)
                {
                  return _myValue=value;
                },
        ),
         SizedBox(height:15.0),
         new RaisedButton(
        color: Colors.white70,
        child:new Text("Post ", style:GoogleFonts.poiretOne(
              fontSize: 26,
              color: Colors.grey[700],
              fontStyle:FontStyle.normal,
              fontWeight: FontWeight.bold,)),
                elevation: 10,
                 shape: OutlineInputBorder(borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide.none),
                
         onPressed: uploadStatusImage ,)

        ]
      )

    ),
  );

}



}