import 'package:fira/models/tickets_model.dart';
import 'package:flutter/material.dart';

class FiraContainer extends StatefulWidget {
  final Tickets data;
  const FiraContainer({super.key, required this.data});

  @override
  State<FiraContainer> createState() => _FiraContainerState();
}

class _FiraContainerState extends State<FiraContainer> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(widget.data.id!),
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 204, 204, 204))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 68, 68, 68)),
                ),
                Text(widget.data.dateTime!)
              ],
            ),
            Text("Discription : ${widget.data.disctiption}"),
            if (isExpanded) ...[
              if (widget.data.attachments.isNotEmpty) ...[
                const Text("Attachments 🔗"),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.data.attachments
                          .map((e) => Image.network(
                                e,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                    ))
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("📌 Location: ${widget.data.location}"),Text("Owner: ${widget.data.ownerName}")],)

            ]
          ],
        ),
      ),
    );
  }
}
