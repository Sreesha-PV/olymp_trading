import 'package:flutter/material.dart';

class MarketDrawer extends StatelessWidget {
  const MarketDrawer({super.key});

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
                  'Market',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(width: 90),
                const Icon(Icons.info_outline),
                const SizedBox(width: 40),
                IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close))
              ],
            ),
          
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.grey[800],
            child: const ListTile(
              title: Text(
                'My Purchases & Rewards',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.white,),              
            ),
          ),
        ],
      ),
    );
  }
}















