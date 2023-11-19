import 'package:fira/models/tickets_model.dart';
import 'package:fira/services/auth_services.dart';
import 'package:fira/services/ticket_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketListBloc extends Bloc<TicketRepoEvent, TicketListState> {
  final TicketsServices _ticketService;

  TicketListBloc(this._ticketService) : super(TicketListInitial()) {
    on<TicketRepoEvent>((event, emit) async {
      if (event == TicketRepoEvent.all) {
         emit.forEach(_ticketService.getAll(), onData: (data){
          return TicketListLoaded(data);
        });
      } else if (TicketRepoEvent.user == event) {
        String uid = (await FiraAuthService().currentUser())!.uid;
        emit.forEach(_ticketService.getUser(uid), onData: (data){
          return TicketListLoaded(data);
        });
      }
    });
  }
}

@immutable
abstract class TicketListState {}

class TicketListInitial extends TicketListState {}

class TicketListLoading extends TicketListState {}

class TicketListLoaded extends TicketListState {
  final List<Tickets> tickets;

  TicketListLoaded(this.tickets);
}

enum TicketRepoEvent { user, all }
