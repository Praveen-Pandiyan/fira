import 'package:fira/widgets/home_page/add_new_fira.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("No Fira here"),
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
