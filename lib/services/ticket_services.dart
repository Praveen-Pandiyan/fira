
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tickets_model.dart';

class TicketsServices {
  final ticketCollection= FirebaseFirestore.instance.collection('tickets');
  
  Future<void> add(Tickets ticket) {
    return ticketCollection.add(ticket.toDoc());
  }

   Future<void> delete(Tickets ticket) async {
    return ticketCollection.doc(ticket.id).delete();
  }

   Stream<List<Tickets>> getAll() {
    return ticketCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Tickets.fromFirebase(doc))
          .toList();
    });
  }
   Stream<List<Tickets>> getUserTicket(String uid) {
    return ticketCollection.where('uid',isEqualTo: uid).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Tickets.fromFirebase(doc))
          .toList();
    });
  }
}