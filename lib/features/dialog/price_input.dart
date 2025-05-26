import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/provider/tradesettings_provider.dart';
import 'package:provider/provider.dart';

class PriceInputScreen extends StatefulWidget {
  const PriceInputScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PriceInputScreenState createState() => _PriceInputScreenState();
}

class _PriceInputScreenState extends State<PriceInputScreen> {
  String input = '';
  final FocusNode _focusNode = FocusNode();
  bool _isFocused= false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState(){
    super.initState();
    _focusNode.addListener((){
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  void onKeyPress(String key) {
    setState(() {
        if (key == '⌫') {
        if (_controller.text.isNotEmpty) {
          _controller.text =
              _controller.text.substring(0, _controller.text.length - 1);
        }
      } else {
        _controller.text += key;
      }
      // if (key == '←') {
      //   if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      // } else {
      //   input += key;
      // }
    });
  }

  Widget buildKey(String label,{TextStyle? textStyle, Color? backgroundColor}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onKeyPress(label),
        child: Container(
          // margin: const EdgeInsets.all(4),
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor ??  AppColors.background,
            // borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textColor, fontSize: 24),
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
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  _buildFilterChip('Any Profitability', width: 140),
                    const SizedBox(width: 10),
                  _buildFilterChip('from 70%', width: 100),
                  const SizedBox(width: 10),
                  _buildFilterChip('from 80%', width: 100),
                  const SizedBox(height: 10,), 
                ],
              ),

              const SizedBox(height: 6),
              TextForm(controller: _controller), 

              const SizedBox(height: 4,),
              const Text(
                "Your trade will be opened if the asset price reaches and the profitability is 90% or higher" ,
                style: TextStyle(color: AppColors.buttonDisabled),),

              ...[
                ['1', '2', '3'],
                ['4', '5', '6'],
                ['7', '8', '9'],
                ['.', '0', '⌫'],
              ].map(
                (row) => Row(
                  children: row.map(buildKey).toList(),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.greenAccent),
                  gradient: const LinearGradient(
                    colors: [
                        Color.fromARGB(255, 76, 238, 238),
                       Color.fromARGB(255, 74, 231, 43),
                    ]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      final provider = Provider.of<TradeSettingsProvider>(context, listen: false);
                      provider.setCustomLabels(
                        "Price Set: ${_controller.text}",
                        "Profit when ${_controller.text} hit",
                      );

                      Navigator.pop(context); 
                    },

                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),


              // const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     // backgroundColor: Colors.greenAccent,
              //     // foregroundColor: Colors.black,
              //     minimumSize: const Size(double.infinity, 50),
              //   ),
              //   child: const Text('Save'),
              // ),

            
            ],
          ),
        ),
      ),
    ),
  );
}



  Widget _buildFilterChip(String text, {required double width}) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, color: AppColors.textColor),
          ),
        ),
      ),
    );
  }
}


class TextForm extends StatefulWidget {
  final TextEditingController controller;
  const TextForm({super.key, required this.controller, });

  @override
  State<TextForm> createState() => TextFormState();
}

class TextFormState extends State<TextForm> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isEditing = true;
        });
      },
    child: Container(
        height: 56,
        // width: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: isEditing ? AppColors.focusColor : AppColors.borderColor,
            width: isEditing ? 2 : 1
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.bgColor
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isEditing ? AppColors.focusColor : AppColors.labelColor,
                  fontSize: 12,
                ),
                child: const Text('Opening Price'),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: widget.controller,
                  enabled: isEditing,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
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

