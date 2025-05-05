import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/provider/dropdown_provider.dart';
import 'package:provider/provider.dart';

class ByPricePage extends StatelessWidget {
  const ByPricePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profitability',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Consumer<ProfitabilityProvider>(
                      builder: (context, model, child) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: DropdownButton<String>(
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
                          'from 90%',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  _OpeningPriceField(
                    label: 'Opening Price',
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
                    'Your trade will be opened if the asset price ',
                    style: TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 163, 185, 179)),
                  )
                ],
              ),
            ),
            const Row(
              children: [
                Text(
                  'reaches 784.0193 and the profitability is ',
                  style: TextStyle(
                      fontSize: 11, color: Color.fromARGB(255, 163, 185, 179)),
                )
              ],
            ),
            const Row(
              children: [
                Text('70% or higher ',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color.fromARGB(255, 163, 185, 179),
                    ))
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
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 76, 238, 238),
                          Color.fromARGB(255, 74, 231, 43),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
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
class _OpeningPriceField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const _OpeningPriceField({
    required this.label,
    required this.controller,
  });

  @override
  _OpeningPriceFieldState createState() => _OpeningPriceFieldState();
}

class _OpeningPriceFieldState extends State<_OpeningPriceField> {
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
          _borderColor =
              widget.controller.text.isEmpty ? Colors.red : Colors.grey[800]!;
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
                top: _focusNode.hasFocus || widget.controller.text.isNotEmpty
                    ? 0
                    : 16,
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
                    onChanged: (value) {
                      setState(() {
                        _borderColor =
                            value.isEmpty ? Colors.red : Colors.grey[800]!;
                        _titleColor =
                            value.isEmpty ? Colors.red : Colors.grey[400]!;
                      });
                    },
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



// class TradeBottomSection extends StatefulWidget {
//   const TradeBottomSection({super.key});

//   @override
//   State<TradeBottomSection> createState() => _TradeBottomSectionState();
// }

// class _TradeBottomSectionState extends State<TradeBottomSection> {
//   bool isButtonDisabled = false;

//   void handleOrder(int orderType, BuildContext context) async {
//     setState(() {
//       isButtonDisabled = true;
//     });

//     await createOrder(orderType, context);

//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(orderType == 0 ? 'Down order placed!' : 'Up order placed!'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }

//     // Re-enable the button after 2 seconds
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           isButtonDisabled = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       color: Colors.black,
//       child: Column(
//         children: [
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _fixedTimeInputField("1 min", context),
//               const SizedBox(width: 5),
//               _fixedAmountInputField("AED 0", context),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               OrderButton(
//                 label: "Down",
//                 color: isButtonDisabled ? Colors.grey : const Color.fromARGB(255, 228, 73, 86),
//                 icon: CupertinoIcons.arrow_down,
//                 onTap: isButtonDisabled
//                     ? null
//                     : () {
//                         handleOrder(0, context);
//                       },
//               ),
//               const SizedBox(width: 5),
//               _iconButton(context, Icons.watch_later_outlined),
//               const SizedBox(width: 10),
//               OrderButton(
//                 label: "Up",
//                 color: isButtonDisabled ? Colors.grey : const Color.fromARGB(255, 34, 175, 93),
//                 icon: CupertinoIcons.arrow_up,
//                 onTap: isButtonDisabled
//                     ? null
//                     : () {
//                         handleOrder(1, context);
//                       },
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }


// }
