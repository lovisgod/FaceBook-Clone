import 'package:facebook_clone/screens/write_post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:facebook_clone/util/timeCalc.dart';

class PostsScreen extends StatefulWidget {
  
  PostsScreen();

  @override
  _PostScreenState createState() => _PostScreenState();
  }
  
  class _PostScreenState extends State<PostsScreen> {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser me;
    String profilePics;
    @override
    void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
     
    return WillPopScope(
          onWillPop: () {
           SystemNavigator.pop();
          },
          child: Scaffold(
           body: SafeArea(
            child: Container(
               padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                      'FaceBook',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1977F1)
                      ),
                  ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      width: 129.0,
                      height: 25.0,
                      alignment: Alignment.center,
                      child: Text(
                        'Clone Mode',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF484E55),
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  )
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
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
                        height: 40.0,
                        child: TextField(
                          onTap: (){
                             Navigator.push(
                             context,
                             MaterialPageRoute(
                             builder: (_) => PostsCreateScreen()
                            ),
                           );
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                          hintText: 'Write something',
                          // border: InputBorder.none,
                          border: OutlineInputBorder(      
	                    borderSide: BorderSide(color: Color(0xFFE7E9ED)),
                          borderRadius: BorderRadius.circular(20.0) 
	                  ),  
                        ),
                        keyboardType: TextInputType.text,
                        ),
                      ),
                     ),
                  )
                  ],
                ),
                SizedBox(height: 15.0),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('posts').snapshots(),
                    builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();
                   print(snapshot.data.documents);  
                  // return Text('this is this');
                  return _buildList(snapshot.data.documents);
                  },
               ),
                ),
              ],
          ),
            ),
        ),
      ),
    );
  }

  Widget _buildPostItem(Post post) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
      width: double.infinity,  
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.blue
                    ),
                    borderRadius: BorderRadius.circular(100.0)
                  ),
                  child: Text(
                    post.name.substring(0, 2).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
               ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text( 
                  post.name.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                   MyTimer().duration(post.time).toString(),
                  style: TextStyle(
                    color: Color(0xFFC4C4C4),
                    fontWeight: FontWeight.normal
                  ),
                ),
                ],
              )
            ],
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              post.message,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: Colors.black
              ),
            ),
          ),
          SizedBox(height: 15.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              post.mediaUrl.toString(),
              height: 200.0,
              width: 300.0,
              fit: BoxFit.cover,
              ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: GestureDetector(
                    onTap: (){
                      post.reference.updateData({'likes': FieldValue.increment(1)});
                    },
                    child: Container(
                    width: 35.0,
                    height: 35.0,
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFFEF0124),
                    ),
               ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  '${post.likes} likes',
                  style: TextStyle(
                    color: Color(0xFFEF0124),
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
            Expanded(
                child: Padding(
                padding: EdgeInsets.only(right: 10.0, bottom: 5.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: TextField(
                    onTap: (){

                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                    hintText: 'Write comment',
                    // border: InputBorder.none,
                    border: OutlineInputBorder(      
	                     borderSide: BorderSide(color: Color(0xFFE7E9ED)),
                    borderRadius: BorderRadius.circular(20.0) 
	              ),  
                  ),
                  keyboardType: TextInputType.text,
                  ),
                ),
               ),
            )
            ],
          )
        ],
      ),
        ),
    );
  }


  _getUser() async {
    FirebaseUser user = await auth.currentUser();
    debugPrint(user.providerId);
    if (user != null) {
      debugPrint(user.email);
      setState(() {
        user = user;
        profilePics = user.email;
      });
      debugPrint(this.profilePics);
    }
  }

  _buildList(List<DocumentSnapshot> snapShot){
    List<Post> posts;
    posts = snapShot.map((data) => getPosts(data)).toList();
    debugPrint(posts.length.toString());
     return  ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                Post post = posts[index];
                return ListTile(title: _buildPostItem(post));
              }
            );

  }

   Post getPosts(DocumentSnapshot snapshot){
    return Post.fromSnapshot(snapshot);
  }
}