import 'package:fira/bloc/tickets/tickets_bloc.dart';
import 'package:fira/widgets/home_page/add_new_fira.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TicketListBloc, TicketListState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        print("frf");
                        context
                            .read<TicketListBloc>()
                            .add(TicketRepoEvent.user);
                      },
                      child: const Text("Me")),
                  TextButton(
                      onPressed: () {
                        print("frf");
                        context.read<TicketListBloc>().add(TicketRepoEvent.all);
                      },
                      child: const Text("All")),
                ],
              ),
              if (state is TicketListLoaded)
                ...state.tickets.map((element) {
                  return Text(element.title, key: Key(element.id!),);
                }).toList()
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                return const AlertDialog(
                  title: Text("Create"),
                  content: AddFiraForm(),
                );
              }));
        },
      ),
    );
  }
}
