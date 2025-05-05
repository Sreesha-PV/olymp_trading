import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/provider/selected_index_provider.dart';
import 'package:provider/provider.dart';

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
      width: 360,
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Payments',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: Colors.white,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 76, 238, 238),
                    Color.fromARGB(255, 74, 231, 43)
                  ]),
                  borderRadius: BorderRadius.circular(8)),
              // child: Card(
              // color: Colors.green,
              child: ListTile(
                leading: const Icon(Icons.wallet),
                iconColor: Colors.black,
                title: const Text(
                  'Deposit',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Provider.of<SelectedIndexNotifier>(context, listen: false)
                      .updateSelectedIndex(0);
                  Scaffold.of(context).openDrawer();
                  Scaffold.hasDrawer(context);
                },
              ),
              // ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(Icons.wallet_outlined),
                iconColor: Colors.white,
                title: Text(
                  'Withdraw',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(
                  CupertinoIcons.arrow_right_arrow_left,
                  size: 20,
                ),
                iconColor: Colors.white,
                title: Text(
                  'Transfer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(Icons.history),
                iconColor: Colors.white,
                title: Text(
                  'Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
