import 'package:cloud_firestore/cloud_firestore.dart';

class Tickets {
  final String? id;
  final String title;
  final String disctiption;
  final List<String> attachments;
  final String location;
  final num dateTime;
  Tickets(
      {this.id,
      required this.title,
      required this.disctiption,
      required this.attachments,
      required this.location,
      required this.dateTime});

  static Tickets fromFirebase(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Tickets(
          id: doc.id,
          title: doc.data()!['title'],
          disctiption: doc.data()!['discription'],
          attachments: doc.data()!['attachments'],
          location: doc.data()!['location'],
          dateTime: doc.data()!['date']);

  Map<String, dynamic> toDoc() {
    return {
      "title": title,
      "discription": disctiption,
      "attachments": attachments,
      "location": location,
      "date": dateTime
    };
  }
}
