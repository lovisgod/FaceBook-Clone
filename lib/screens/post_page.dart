import 'package:facebook_clone/screens/write_post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostsScreen extends StatefulWidget {
  
  PostsScreen();

  @override
  _PostScreenState createState() => _PostScreenState();
  }
  
  class _PostScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
          onWillPop: () {
           SystemNavigator.pop();
          },
          child: Scaffold(
           body: SafeArea(
            child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Column(
                  children: <Widget>[
                    Text(
                    'Salami Alao',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    '2 hours ago',
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left:20.0, right: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  'src',
                  height: 300.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                  ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: GestureDetector(
                      onTap: (){

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
                    '24 likes',
                    style: TextStyle(
                      color: Color(0xFFEF0124),
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Container(
                    height: 30.0,
                    child: TextField(
                      onTap: (){

                      },
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
    );
  }
}