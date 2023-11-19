import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fira/models/tickets_model.dart';
import 'package:fira/services/ticket_services.dart';
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
    isDense: true,
  );
  late String title, dis, location;
  List<File> attachments = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onSaved: (val) {
                  title = val!;
                },
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
                onSaved: (val) {
                  dis = val!;
                },
                maxLines: 3,
                decoration: _inputDecoration.copyWith(
                  labelText: "Discription",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 5) {
                    return 'DIscription should be atleast 6 characters in length';
                  }
                  return null;
                },
              ),
              TextFormField(
                onSaved: (val) {
                  location = val!;
                },
                decoration: _inputDecoration.copyWith(
                    labelText: "Location",
                    suffixIcon: const Icon(Icons.location_on_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 5) {
                    return 'Location should be atleast 3 characters in length';
                  }
                  return null;
                },
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Attachments"),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowMultiple: true,
                                  allowedExtensions: [
                                    'jpg',
                                    'jpeg',
                                    'png',
                                    'webp'
                                  ],
                                );
                                if (result != null) {
                                  setState(() {
                                    attachments.addAll(result.paths
                                        .map((path) => File(path!))
                                        .toList());
                                  });
                                } else {
                                  debugPrint("user exist picker");
                                }
                              },
                              icon: const Icon(Icons.add)),
                          if (attachments.isNotEmpty)
                            ...attachments
                                .map((e) => Image.file(
                                      e,
                                      fit: BoxFit.cover,
                                    ))
                                .toList(),
                        ]
                            .map((e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    height: 50,
                                    width: 50,
                                    color: Colors.blueGrey,
                                    child: e,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Uploading Data')),
                    );
                    _formKey.currentState!.save();
                    TicketsServices().add(Tickets(
                      title: title,
                      disctiption: dis,
                      attachmentFiles: attachments,
                      location: location,
                    ));
                    Navigator.pop(context);
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
