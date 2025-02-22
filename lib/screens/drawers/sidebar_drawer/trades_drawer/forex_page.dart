import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForexPage extends StatelessWidget {
  const ForexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Open Position',
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
            padding:  const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(CupertinoIcons.arrow_down_right_arrow_up_left,

             size: 80,color: Colors.grey[800],)],
            ),
          ),
          const SizedBox(height: 20,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have no open Fixed trades on', style: TextStyle(color: Color.fromARGB(255, 230, 245, 247)),),
            ],
          ),
        
             const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('this account', style: TextStyle(color: Color.fromARGB(255, 230, 245, 247)))
            
              ],
            ),
          
          const SizedBox(height: 20),
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
                        onPressed: () {},
                        child: const Text(
                          'Explore Assets',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ))
        
        ]
      )
    );
  }
}