import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MyTimer {
  String duration(Timestamp timestamp) {
    String x;
    final time = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(time).inDays;
    final hdif = now.difference(time).inHours;
    if (hdif > 24) {
      x = '${difference} days ago';
    }
    else {
      x = '${hdif} hours ago';
    }
    return x;
 } 
}