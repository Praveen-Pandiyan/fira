import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/tickets_model.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

class TicketsServices {
  final ticketCollection = FirebaseFirestore.instance.collection('tickets');

  Future<void> add(Tickets ticket) async {
    String docId = const Uuid().v4();
    List<String> imageUrls = [];
    if (ticket.attachmentFiles.isNotEmpty) {
      await Future.forEach(ticket.attachmentFiles, (element) async {
        Reference ref = FirebaseStorage.instance
            .ref('attachments/$docId/${imageUrls.length}');
        await ref.putData(element.readAsBytesSync()).whenComplete(() async {
          imageUrls.add(await ref.getDownloadURL());
        });
      });
      ticket.attachments = imageUrls;
    }
   await ticketCollection.doc(docId).set(ticket.toDoc());
  }

  Future<void> delete(Tickets ticket) async {
    return ticketCollection.doc(ticket.id).delete();
  }

  Stream<List<Tickets>> getAll() {
    return ticketCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Tickets.fromFirebase(doc)).toList();
    });
  }

  Stream<List<Tickets>> getUserTicket(String uid) {
    return ticketCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Tickets.fromFirebase(doc)).toList();
    });
  }
}
