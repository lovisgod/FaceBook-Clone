import 'package:cloudinary_client/models/CloudinaryResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostsCreateScreen extends StatefulWidget {
  
  PostsCreateScreen();

  @override
  _PostCreateScreenState createState() => _PostCreateScreenState();
  
    }
  
  class _PostCreateScreenState extends State<PostsCreateScreen> {
    TextEditingController postController = TextEditingController();
    Color sendColor = Color(0xFF484E55);
     File _image;
     String imageUrl;
     String userName;
     final dbRef = Firestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseUser me;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Image(
                         height: 20.0,
                         width: 20.0,
                         image: AssetImage('assets/images/back_arrow.png'),
                         fit: BoxFit.cover,
                      ),
                    ),
                  ),
                 GestureDetector(
                   onTap: (){
                    _uploadPost();
                   },
                   child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Image(
                         height: 20.0,
                         width: 20.0,
                         image: AssetImage('assets/images/send_icon.png'),
                         fit: BoxFit.cover,
                         color: this.sendColor,
                      ),
                ),
                 )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(100.0)
                    ),
              ),
                ),
              Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Container(
                    child: TextField(
                      controller: this.postController,
                      style: TextStyle(
                        height: 2.0
                      ),
                      onChanged: (value) => _updatePost(),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                      hintText: 'Write something',
                      // border: InputBorder.none,
                      border: OutlineInputBorder(      
	                    borderSide: BorderSide(color: Color(0xFFE7E9ED)),
                      borderRadius: BorderRadius.circular(20.0) 
	                  ),  
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: null
                    ),
                  ),
                 ),
              )
              ],
            ),
            SizedBox(height: 10.0),
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                 GestureDetector(
                   onTap: (){
                    pickImageFromGallery(ImageSource.gallery);
                   },
                    child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Image(
                         height: 20.0,
                         width: 20.0,
                         image: AssetImage('assets/images/pick_image.png'),
                         fit: BoxFit.cover,
                      ),
                ),
                 )
                ],
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: showImage(),
              )
          ],
        ),
      ),
    );
  }


  void _updatePost() {
    setState(() {
      if (this.postController.text.length == 0){
        this.sendColor = Color(0xFF484E55);
      } else {
        this.sendColor = Color(0xFF1977F1);
      }
    });
  }

  pickImageFromGallery(ImageSource source) async {
   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Widget showImage() {
    return _image == null
            ? Text('No media selected.',
                  textAlign: TextAlign.center,
               )
            :Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 1.0),
              child: Container(
                width: double.infinity,
                height: 200,
                 decoration: BoxDecoration(
                   border: Border.all(
                     color: Colors.white
                   ),
                 ),
                child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.file(_image,
                      fit: BoxFit.cover,
                    ),
                ),
              ),
            );
  }

 _uploadImage(File file) async {
   if (file != null) {
    CloudinaryClient client = new CloudinaryClient('832526582587237', 'STcTA55N9MAlyJzKy3WXiSjHPxA', 'psirius-eem');
    CloudinaryResponse response = await client.uploadImage(file.path.toString());
    if (response.secure_url != null) {
      setState(() {
        this.imageUrl = response.secure_url;
      });
    } else {
       EasyLoading.showError('ERROR');
    }
   }
  }

  // upload documents 
  _uploadPost() async {
    try {
         EasyLoading.show(status: 'Please wait..');
         await  _uploadImage(this._image);
        DocumentReference ref =  await dbRef.collection('posts').add({
        'message': postController.text.toString(),
        'name': this.userName,
        'time': DateTime.now(),
        'mediaUrl': this.imageUrl,
        'likes': 0,
      });
      if (ref != null) {
        EasyLoading.showSuccess('Success');
        Navigator.pop(context, false);
      }  
    } catch (e) {
      EasyLoading.showError(e.message);
    }

  }

  // get profile
   _getUser() async {
    FirebaseUser user = await auth.currentUser();
    if (user != null) {
      debugPrint(user.email);
      setState(() {
        me = user;
        userName = user.email.substring(0, 5);
        // profilePics = user.email;
      });
      debugPrint(this.userName);
    }
  }

}