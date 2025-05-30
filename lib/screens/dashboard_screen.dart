import 'package:flutter/material.dart';
import 'package:olymp_trade/screens/drawers/sidebar_drawer/market_drawer.dart';
import 'package:provider/provider.dart';
import 'drawers/account_drawer.dart';
import 'drawers/payment_drawer.dart';
// import 'drawers/profile_drawer.dart';
// import 'drawers/sidebar_drawer/events_drawer.dart';
// import 'drawers/sidebar_drawer/trades_drawer.dart';
import 'drawers/sidebar_drawer/trades_drawer.dart';
import 'provider/drawer_provider.dart';
import 'provider/selected_index_provider.dart';
import 'sidebar/rsidebar_section.dart';
import 'sidebar/sidebar_section.dart';



class TradeScreen extends StatelessWidget {
  TradeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      
      drawer: Consumer<DrawerProvider>(
        builder: (context, drawerProvider, child) {
          return drawerProvider.selectedDrawer; 
        },
      ),

      body: Row(
        children: [ 
          SidebarSection(
            onItemSelected: (drawerContent) {
       
              Provider.of<DrawerProvider>(context, listen: false)
                  .updateDrawerContent(drawerContent);
              scaffoldKey.currentState?.openDrawer(); 
            },
          ),
          // const SidebarSection(),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  const TopSection(),
                  Expanded(child: RSidebarSection()),
                ],
              ),
              endDrawer: Consumer<SelectedIndexNotifier>(
                builder: (context, selectedIndexNotifier, child) {
                  return selectedIndexNotifier.selectedIndex == 0
                      ? AccountDrawer(
                        
                          selectedIndex: selectedIndexNotifier.selectedIndex,
                          onSelect: (index) {
                            selectedIndexNotifier.updateSelectedIndex(index);
                          },
                        )
                      : PaymentDrawer(
                          selectedIndex: selectedIndexNotifier.selectedIndex,
                          onSelect: (index) {
                            selectedIndexNotifier.updateSelectedIndex(index);
                          },
                        );
                      
                      
                     
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.grey[800],
                onPressed: () {},
                child: const Icon(Icons.add, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Halal Market Axis",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    Text("FT - 85%",
                        style: TextStyle(color: Colors.green, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              
              GestureDetector(
                onTap: () {
                  Provider.of<SelectedIndexNotifier>(context, listen: false)
                      .updateSelectedIndex(0); 
                  Scaffold.of(context).openEndDrawer(); 
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[850],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "AED 0.00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "AED Account",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8), 
                      const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Payment Button (Opens Right Drawer for Payment)
              GestureDetector(
                onTap: () {
                  Provider.of<SelectedIndexNotifier>(context, listen: false)
                      .updateSelectedIndex(1); 
                  Scaffold.of(context).openEndDrawer(); 
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 50, 129, 52),
                      Colors.green,
                      Colors.greenAccent
                    ]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "Payment",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),  
                      SizedBox(width: 8),
                      Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              CircleAvatar(
                backgroundColor: Colors.grey[850],
                foregroundColor: Colors.white,
                radius: 25,
                child: const Icon(Icons.person_2_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}












import 'package:flutter/material.dart';

class PriceInputScreen extends StatefulWidget {
  @override
  _PriceInputScreenState createState() => _PriceInputScreenState();
}

class _PriceInputScreenState extends State<PriceInputScreen> {
  String input = '';

  void onKeyPress(String key) {
    setState(() {
      if (key == '←') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else {
        input += key;
      }
    });
  }

  Widget buildKey(String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onKeyPress(label),
        child: Container(
          margin: EdgeInsets.all(4),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Opening Price',
              style: TextStyle(color: Colors.greenAccent, fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                input,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // Number Pad
            ...[
              ['1', '2', '3'],
              ['4', '5', '6'],
              ['7', '8', '9'],
              ['.', '0', '←'],
            ].map(
              (row) => Row(
                children: row.map(buildKey).toList(),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}













import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePickerDemo extends StatefulWidget {
  @override
  _DateTimePickerDemoState createState() => _DateTimePickerDemoState();
}

class _DateTimePickerDemoState extends State<DateTimePickerDemo> {
  DateTime selectedDateTime = DateTime.now();

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: selectedDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                selectedDateTime = newDateTime;
              });
            },
            use24hFormat: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Date & Time Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selected: ${selectedDateTime.toLocal()}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showPicker(context),
              child: Text("Pick Date & Time"),
            ),
          ],
        ),
      ),
    );
  }
}


