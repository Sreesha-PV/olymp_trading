
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpDrawer extends StatelessWidget {
  const HelpDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),

      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                const Text(
                  'Help',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(width: 160),
                IconButton(
                  onPressed: (){Navigator.pop(context);}, 
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          // Wrap the Row inside SingleChildScrollView
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 140,
                    width: 140, // Or make this Flexible instead of fixed
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.help_outline),
                          SizedBox(height: 20),
                          Text('Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('We are here for you ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('24/7 ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 140,
                    width: 140, // Or make this Flexible instead of fixed
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(height: 20),
                          Text('Help Center', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('Get to know ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('the platform ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Removed the Expanded widget here as well
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    width: 140, // Or make this Flexible instead of fixed
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.cast_for_education),
                          SizedBox(height: 20),
                          Text('Education', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('Expand your ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Knowledge ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140,
                    width: 140, // Or make this Flexible instead of fixed
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column( 
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(CupertinoIcons.graph_square),
                          SizedBox(height: 20),
                          Text('Trading Tutorials', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Text('Learn how ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('to open a trade', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}



