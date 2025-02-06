import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsDrawer extends StatelessWidget {
  const EventsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const Text(
                  'Events',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(width: 90),
                const Icon(CupertinoIcons.clock),
                const SizedBox(width: 40),
                IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close))
              ],
            ),
          ),
        ]
      )
    );
  }
}
