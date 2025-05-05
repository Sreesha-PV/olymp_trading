import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/provider/dropdown_provider.dart';
import 'package:provider/provider.dart';

class ByTimePage extends StatelessWidget {
  const ByTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profitability',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Consumer<ProfitabilityProvider>(
                    builder: (context, model, child) {
                      return DropdownButton<String>(
                        value: model.selectedValue,
                        isExpanded: true,
                        icon: const Icon(CupertinoIcons.chevron_down),
                        underline: const SizedBox.shrink(),
                        onChanged: (String? newValue) {
                          model.selectedValue = newValue ?? 'any';
                        },
                        items: <String>[
                          'any',
                          'from 70%',
                          'from 80%',
                          'from 90%'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  _OpeningTimeField(
                    label: 'Opening Time',
                    controller: priceController,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text(
                    'Your trade will be open today 13:00 if ',
                    style: TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 230, 245, 247)),
                  )
                ],
              ),
            ),
            const Row(
              children: [
                Text(
                  'the profitability is 70% or higher ',
                  style: TextStyle(
                      fontSize: 11, color: Color.fromARGB(255, 230, 245, 247)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 6),
              child: Row(
                children: [
                  Container(
                    width: 220,
                    height: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 76, 238, 238),
                        Color.fromARGB(255, 74, 231, 43)
                      ]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OpeningTimeField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const _OpeningTimeField({
    required this.label,
    required this.controller,
  });

  @override
  _OpeningPriceFieldState createState() => _OpeningPriceFieldState();
}

class _OpeningPriceFieldState extends State<_OpeningTimeField> {
  final FocusNode _focusNode = FocusNode();
  Color _borderColor = Colors.grey[800]!;
  Color _titleColor = Colors.grey[400]!;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          _borderColor = const Color.fromARGB(255, 102, 240, 83);
          _titleColor = Colors.green;
        } else {
          _borderColor = Colors.grey[800]!;
          _titleColor = Colors.grey[400]!;
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 225,
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 24, 23, 23),
          ),
          child: Stack(
            children: [
              Positioned(
                top: _focusNode.hasFocus ? 0 : 16,
                left: 10,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: _titleColor,
                    fontSize: 12,
                  ),
                  child: Text(widget.label),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    focusNode: _focusNode,
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
