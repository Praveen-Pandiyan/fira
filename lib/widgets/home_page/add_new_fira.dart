import 'package:flutter/material.dart';

class AddFiraForm extends StatefulWidget {
  const AddFiraForm({super.key});

  @override
  State<AddFiraForm> createState() => _AddFiraFormState();
}

class _AddFiraFormState extends State<AddFiraForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: "First Fira",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 6) {
                  return 'Title should be atleast 6 characters in length';
                }
                return null;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length > 5) {
                  return 'Title should be atleast 6 characters in length';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
