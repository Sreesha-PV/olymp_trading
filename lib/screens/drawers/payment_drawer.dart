import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/selected_index_provider.dart';

class PaymentDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const PaymentDrawer({
    super.key,
    required this.selectedIndex, 
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {



    return Drawer(
  
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          const Row(
            children: [
              Text(
                'Payments',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Container(

            height: 70,
            child: Card(
              color: Colors.green,
              child: ListTile(
                leading: const Icon(Icons.wallet),
                iconColor: Colors.black,
                title: const Text(
                  'Deposit',
                  style: TextStyle(color: Colors.black),),
                  onTap: () {
                    Provider.of<SelectedIndexNotifier>(context,listen:false)
                    .updateSelectedIndex(0);
                    Scaffold.of(context).openDrawer();
                    Scaffold.hasDrawer(context);
                  },
                // onTap: () =>
                //   onSelect(0), 
                //   selected: selectedIndex == 0, 
                  
              ),
            ),
          ),

          Container(
            height: 70,
            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(Icons.wallet_rounded),
                iconColor: Colors.white,
                title: Text('Withdraw',style: TextStyle(color: Colors.white),),
                // onTap: () => onSelect(0),
                // selected: selectedIndex == 0,
              ),
            ),
          ),
          
          Container(
            height: 70,
            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(CupertinoIcons.arrow_right_arrow_left),
                iconColor: Colors.white,
                title: Text('Transfer',style: TextStyle(color: Colors.white),),
                // onTap: () => onSelect(0),
                // selected: selectedIndex == 0,
              ),
            ),
          ),
          Container(
            height: 70,

            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(Icons.history),
                iconColor: Colors.white,
                title: Text('Transaction',style: TextStyle(color: Colors.white),),
                // onTap: () => onSelect(0),
                // selected: selectedIndex == 0,
              ),
            ),
          )
        ],
      ),
    );
  }
  
 
}

