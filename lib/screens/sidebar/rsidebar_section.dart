import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olymp_trade/screens/showDialog/up/up_showdialog.dart';
import 'package:provider/provider.dart';

import '../provider/enable_order_provider.dart';
import '../provider/order_provider.dart';
import '../provider/tabbar_provider.dart';

class RSidebarSection extends StatelessWidget {
  const RSidebarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController(text: '0');
    final TextEditingController durationController = TextEditingController();

    return SingleChildScrollView(  
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 200,
            color: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0),
                  child: Row(
                    children: [
                      AmountField(controller: amountController),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 8),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          minimumSize: const Size(75, 30),
                        ),
                        child: Icon(
                          CupertinoIcons.minus,
                          color: Colors.grey[800],
                          size: 19,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          minimumSize: const Size(75, 30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.grey[800],
                          size: 19,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Row(
                    children: [
                      DurationField(controller: durationController),
                    ],
                  ),
                ),

                Row(
                  children: [
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 8),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          minimumSize: const Size(75, 30),
                        ),
                        child: const Icon(
                          CupertinoIcons.minus,
                          color: Color.fromARGB(255, 163, 185, 179),
                          size: 19,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          minimumSize: const Size(75, 30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 163, 185, 179),
                          size: 19,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 24, 23, 23),
                        ),
                        child: TextButton(
                          onPressed: () {
                            String amount = amountController.text;
                            if (amount.isNotEmpty) {
                              Provider.of<OrderProvider>(context, listen: false)
                                  .placeOrder(amount);
                            }
                            Provider.of<TabVisibilityProvider>(context, listen: false)
                                .toggleTabBarVisibility();
                            Provider.of<EnableOrderProvider>(context, listen: false)
                                .toggleOrder();
                          },
                          child: const Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Enable',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Orders',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 50),
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                    Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 12),
                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 34, 175, 93),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              upDialog(context);
                            },
                            child: const Text(
                              'Up',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          const Icon(
                            CupertinoIcons.arrow_up,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 12),
                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 73, 86),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              upDialog(context);
                            },
                            child: const Text(
                              'Down',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 41),
                          const Icon(
                            CupertinoIcons.down_arrow,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                // Add more widgets here...

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AmountField extends StatefulWidget {
  final TextEditingController controller;

  const AmountField({super.key, required this.controller});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
        });
      },
      child: Container(
        height: 56,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: isEditing ? Colors.green : Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 24, 23, 23),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isEditing ? Colors.green : Colors.grey[400]!,
                  fontSize: 12,
                ),
                child: const Text('Amount'),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: widget.controller,
                  enabled: isEditing,
                  keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationField extends StatefulWidget {
  final TextEditingController controller;

  const DurationField({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _DurationFieldState createState() => _DurationFieldState();
}

class _DurationFieldState extends State<DurationField> {
  final TextEditingController _controller = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller.text = '00h 02m';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
          _controller.text = '00h 02m';
        });
      },
      child: Container(
        height: 56,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: isEditing ? Colors.green : Colors.grey[800]!,
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 24, 23, 23),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isEditing ? Colors.green : Colors.grey[400]!,
                  fontSize: 12,
                ),
                child: const Text('Duration'),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _controller,
                  enabled: isEditing,
                  keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (value) {
                    String hours = '00';
                    String minutes = '00';

                    if (value.isNotEmpty) {
                      hours = value.substring(0, value.length > 2 ? 2 : value.length); 
                      minutes = value.length > 2 ? value.substring(3) : '00'; 
                    }

                    setState(() {
                      _controller.text = '$hours' + 'h ' + '$minutes' + 'm';
                    });

                    _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










