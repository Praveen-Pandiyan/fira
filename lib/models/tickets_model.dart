import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Tickets {
  final String? id;
  final String title;
  final String disctiption;
  final List<File> attachmentFiles;
  List<String> attachments;
  String? ownerId,ownerName;
  final String location;
  final String? dateTime;

  Tickets(
      {this.id,
      required this.title,
      required this.disctiption,
      this.attachmentFiles=const [],
      this.attachments =const [],
      required this.location,
      this.ownerId,
      this.ownerName,
      this.dateTime});

  static Tickets fromFirebase(DocumentSnapshot<Map<String, dynamic>> doc) {
    print(doc.data().toString());
      return Tickets(
          id: doc.id,
          title: doc.data()!['title'],
          disctiption: doc.data()!['discription'],
          attachments: doc.data()!['attachments'].cast<String>() ,
          ownerId: doc.data()!['ownerId'],
          ownerName: doc.data()!['ownerName'],
          location: doc.data()!['location'],
          dateTime: doc.data()!['date'].toString());}

  Map<String, dynamic> toDoc() {
    return {
      "title": title,
      "discription": disctiption,
      "attachments": attachments,
      "location": location,
      "ownerId":ownerId,
      "ownerName":ownerName,
      "date": DateTime.now().toString()
    };
  }
}
