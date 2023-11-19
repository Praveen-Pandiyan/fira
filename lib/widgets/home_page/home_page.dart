import 'package:fira/bloc/tickets/tickets_bloc.dart';
import 'package:fira/widgets/home_page/add_new_fira.dart';
import 'package:fira/widgets/home_page/fira_container.dart';
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
    context.read<TicketListBloc>().add(TicketRepoEvent.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fira",
          style: TextStyle(
              color: Colors.orange, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<TicketListBloc, TicketListState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        print("frf");
                        context
                            .read<TicketListBloc>()
                            .add(TicketRepoEvent.user);
                      },
                      child: const Text("My Fira(s)")),
                  TextButton(
                      onPressed: () {
                        print("frf");
                        context.read<TicketListBloc>().add(TicketRepoEvent.all);
                      },
                      child: const Text("All")),
                ],
              ),
              const Divider(),
              if (state is TicketListLoaded) ...[
                if (state.tickets.isEmpty) const Text("Nothing to Show"),
                ...state.tickets.map((element) {
                  return FiraContainer(
                    data: element,
                  );
                }).toList()
              ]
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
