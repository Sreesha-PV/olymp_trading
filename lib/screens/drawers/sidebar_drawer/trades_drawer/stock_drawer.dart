import 'package:flutter/material.dart';


class StocksPage extends StatelessWidget {
  const StocksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(padding: const EdgeInsets.only(left: 15), children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Portfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 120,
                  color: Colors.grey[800],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have no Active Positions on',
                style: TextStyle(color: Color.fromARGB(255, 230, 245, 247)),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('this account', 
              style: TextStyle(color: Color.fromARGB(255, 230, 245, 247)))
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[800],
                    ),
                    child: TextButton(
                        onPressed: () {
                          // openExplorePage(context);
                        },
                        child: const Text(
                          'Explore Assets',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ))
        ]));
  }

  // void openExplorePage(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return const Dialog(
  //           child: ExplorePage(),
  //         );
  //       });
  // }
}
