import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/authentication/authentication_screen.dart';

class ProfileDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;
  final String email; 

  const ProfileDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    required this.email, 
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
              size: 30,
            ),
          ),
        
          const SizedBox(height: 8),
          Text(
            email,  
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 15,),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[800],
            ),
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
            }, child: const Text('Logout',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)),
          )
        ],
      ),
    );
  }
}
