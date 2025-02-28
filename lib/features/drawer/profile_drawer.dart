import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const ProfileDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 360,
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: Colors.white,
              ),
            ],
          ),
          
     
          const SizedBox(height: 50), 
          CircleAvatar(
            radius: 40, 
            backgroundColor: Colors.grey[850], 
            child: const Icon(CupertinoIcons.person,
            color: Colors.white,
            size: 30,),
          ),

        
          const SizedBox(height: 8),
          const Text(
            "User",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
