import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsDrawer extends StatelessWidget {
  const EventsDrawer({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),

      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 12),
                child: Text(
                  'Events',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              const SizedBox(width: 120),
              const Icon(CupertinoIcons.clock),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: Colors.white,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, right: 12),
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'HAPPENING NOW',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 40),
                      const Row(
                        children: [
                          Text(
                            'Welcome to ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            'Olymptrade',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Column(
                        children: [
                          Text(
                            'Ends on',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'May 1',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_right_alt))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
