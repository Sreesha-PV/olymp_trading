import 'package:flutter/material.dart';

class HelpDrawer extends StatelessWidget {
  const HelpDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: const Text('Help'), automaticallyImplyLeading: false),
        const Expanded(
          child: Center(child: Text("Help & Support")),
        ),
      ],
    );
  }
}
