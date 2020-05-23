import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:facebook_clone/util/timeCalc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen(this.ref, this.user);
  final DocumentReference ref;
  final FirebaseUser user;
  final dbRef = Firestore.instance;

  @override
_BottomSheetState createState() => _BottomSheetState();

}

class _BottomSheetState extends State<CommentScreen> {
   TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
            height: 400.0,
            child: new Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text('Comments',
                   style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                     fontSize: 20.0
                   ),
                  ),
                ),
                new Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection('comments').document(widget.ref.documentID.toString()).collection('message').snapshots(),
                        builder: (context, snapshot) {
                        return snapshot.hasData ? _buildCommentList(snapshot.data.documents) : Text('no comment',
                         style: TextStyle(
                           color: Colors.black
                         ),
                        );
                        
                      },
                   ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    alignment: Alignment.center,
                    child: _buildTextComposer(),
                  ),
                ),
              ],
            ),
            decoration: Theme.of(context).platform == TargetPlatform.iOS
                ? new BoxDecoration(
                    border: new Border(
                      top: new BorderSide(color: Colors.grey[200]),
                    ),
                  ) 
                : BoxDecoration(
                  color: Colors.white
                )),
      ),
    );
  }

  Widget comment_item(Post comment) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
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
                padding: EdgeInsets.only(right: 10.0),
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
                    comment.name.substring(0, 2).toUpperCase(),
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
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text( 
                        comment.name.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                ),
                      ),
                 Text(
                   MyTimer().duration(comment.time).toString(),
                  style: TextStyle(
                    color: Color(0xFFC4C4C4),
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal
                  ),
                ),
                ],
              ),
                Container(
                  width: 250.0,
                  child: Text(
                   comment.message.toString(),
                   style: TextStyle(
                     color: Color(0xFF000000),
                     fontSize: 15.0,
                     fontWeight: FontWeight.normal
                   ),
                    ),
                ),
                ],
              )
            ],
          ),
        ],
      ),
        ),
    );
 }

// submmit the comment on the post
  _handleSubmitted() async {
    try {
         EasyLoading.show(status: 'Please wait..');
        DocumentReference ref =  await widget.dbRef.collection('comments').document(widget.ref.documentID.toString()).collection('message').add({
        'message': this._textController.text.toString(),
        'name': widget.user.email.substring(0, 6),
        'time': DateTime.now(),
      });
      if (ref != null) {
        EasyLoading.showSuccess('Success');
        setState(() {
          _textController.text  = '';
        });
      }  
    } catch (e) {
      EasyLoading.showError(e.message);
      EasyLoading.dismiss();
    }
  }

   Widget _buildTextComposer() {
  return new Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: new Row(
      children: <Widget>[
        new Flexible(
          child: new TextField(
                    controller: this._textController,
                    onSubmitted: (String text) => _handleSubmitted(),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                    hintText: 'Write comment',
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
        Container(
        margin:  EdgeInsets.symmetric(horizontal: 4.0),
          child: GestureDetector(
            onTap: this._textController.text.length > 1 ? _handleSubmitted: null,
            child: Image(
                height: 20.0,
               width: 20.0,
               image: AssetImage('assets/images/send_icon.png'),
              fit: BoxFit.cover,
              color: Color(0xFF1977F1),
              ),
             
            //  icon: Image.asset(
            //    'assets/images/send_icon.png',
            //    color: Color(0xFF1977F1),
            //    ),
           
    
          )
   ),
      ],
    ),
  );
 }

  // build the list for the comment
  _buildCommentList(List<DocumentSnapshot> snapShot) {
    List<Post> comments;
    comments = snapShot.map((data) => getComments(data)).toList();
    return new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                    Post comment = comments[index];
                    return ListTile(
                      title: comment_item(comment),
                    );
                },
                itemCount: comments.length,
      );
  }

     Post getComments(DocumentSnapshot snapshot){
    return Post.fromSnapshot(snapshot);
  }
}