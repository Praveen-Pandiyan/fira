import 'package:fira/models/tickets_model.dart';
import 'package:flutter/material.dart';

class AddFiraForm extends StatefulWidget {
  const AddFiraForm({super.key});

  @override
  State<AddFiraForm> createState() => _AddFiraFormState();
}

class _AddFiraFormState extends State<AddFiraForm> {
  final _formKey = GlobalKey<FormState>();
  final _inputDecoration = const InputDecoration(
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
    isDense: true,
  );
  String? title;
  String? dis;
  String? location;
  List<String>? attachments;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onSaved: (val) => title,
                decoration: _inputDecoration.copyWith(labelText: "Title"),
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
                onSaved: (val) => dis,
                maxLines: 3,
                decoration: _inputDecoration.copyWith(
                  labelText: "Discription",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length > 5) {
                    return 'DIscription should be atleast 6 characters in length';
                  }
                  return null;
                },
              ),
              TextFormField(
                onSaved: (val) => location,
               
                decoration: _inputDecoration.copyWith(
                  labelText: "Location",
                  suffixIcon:const Icon(Icons.location_on_outlined)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length > 5) {
                    return 'Location should be atleast 3 characters in length';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: e,
                    ))
                .toList(),
          )),
    );
  }
}
