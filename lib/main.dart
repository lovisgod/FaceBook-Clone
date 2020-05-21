import 'package:facebook_clone/screens/post_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facebook clone',
      home: MyHomePage(),
      color: Color(0xFFE5E5E5),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
       child: ListView(
         padding: EdgeInsets.symmetric(vertical: 70.0),
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
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Connect with friend and stay safe',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                 decoration: InputDecoration(
                  hintText: 'Email Adress',
                  // border: InputBorder.none,
                   enabledBorder: UnderlineInputBorder(      
	                borderSide: BorderSide(color: Color(0xFFE7E9ED)),   
	              ),  
                ),
                keyboardType: TextInputType.text,
                ),
              ),
            ),
            SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                 decoration: InputDecoration(
                  hintText: 'Password',
                  // border: InputBorder.none,
                   enabledBorder: UnderlineInputBorder(      
	                borderSide: BorderSide(color: Color(0xFFE7E9ED)),   
	              ),  
                ),
                keyboardType: TextInputType.text,
                ),
            ),
          ),
          SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 100.0),
              child: RichText(
                text: TextSpan(
                  text: 'By signing up, you have accepted the',
                  style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFC4C4C4)
                ),
                 children: <TextSpan>[
                 TextSpan(text: 'Terms and Conditions', style: TextStyle(
                   color: Color(0xFF1977F1),
                   fontSize: 12.0,
                   fontWeight: FontWeight.normal,
                   )
                   ),
                 TextSpan(text: 'of this service', style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFC4C4C4)
                ),),
               ],
            ), 
            ),
            ),
            SizedBox(height: 20.0),
            Row(
             children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostsScreen()
                  ),
                );
                },
                child: Padding( 
                  padding:EdgeInsets.only(left: 20.0, right: 20.0) ,
                  child: Container(
                  width: 141.0,
                  height: 67.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF1977F1),
                    border: Border.all(color: Color(0xFF1977F1)),
                    borderRadius: BorderRadius.circular(40.0)
                  ),
                   alignment: Alignment.center,
                    child: Text(
                      'Sign in',
                      textScaleFactor: 1.5, // makes the text 50% bigger
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                )),
              ),
             Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (_) => PostsScreen()
                      ),
                   );
                  },
                  child: Padding(
                   padding: EdgeInsets.only(left: 20.0, right: 20.0), 
                   child:Container(
                    width: 141.0,
                    height: 67.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF131F38),
                      border: Border.all(color: Color(0xFF131F38)),
                      borderRadius: BorderRadius.circular(40.0)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Register',
                      textScaleFactor: 1.5, // makes the text 50% bigger
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
               )),
                ),
             )
             ]
          ),
         ],
       ),
     ),
      ),
    );
  }
}
