import 'package:cloud_firestore/cloud_firestore.dart';


class Post {
 String id; 
 final String name;
 final Timestamp time;
 final String message;
 final String mediaUrl;
 final int likes;
 DocumentReference reference;


   Post({
    this.mediaUrl,
    this.name,
    this.time,
    this.message,
    this.likes,
  });

 Post.fromMap(Map<String, dynamic> map, {this.reference})
      
     : 
       id = map['_id'],
       name = map['name'],
       time = map['time'],
       message =map['message'],
       mediaUrl = map['mediaUrl'],
       likes = map['likes'];

 Post.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['message'] = message;
    map['time'] = time;
    map['mediaUrl'] = mediaUrl;
    if (id !=null) {
      map['id'] = id;
    }
    return map;
  }

 @override
 String toString() => "Record<$name>";
}

