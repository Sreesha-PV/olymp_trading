import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/provider/tradesettings_provider.dart';
import 'package:provider/provider.dart';

class TimeSelectionScreen extends StatefulWidget {
  const TimeSelectionScreen({super.key});

  @override
  State<TimeSelectionScreen> createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  String selectedDay = 'Today';
  TimeOfDay selectedTime = TimeOfDay.now();

  List<String> days = ['Today', 'Tomorrow'];
  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        // child: SingleChildScrollView(
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
                ],
              ),
              const SizedBox(height: 20),
              

              Row(
                children: [
                  // Day Picker
                  SizedBox(
                    width: 120,
                    height: 200,
                    child: CupertinoPicker(
                    backgroundColor: Colors.transparent, 
                    itemExtent: 32,
                    scrollController: FixedExtentScrollController(
                      initialItem: days.indexOf(selectedDay),
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedDay = days[index];
                      });
                    },
                    children: days.map((day) {
                      return Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  )

                    // child: CupertinoPicker(
                    //   backgroundColor: Colors.transparent,
                    //   itemExtent: 32,
                    //   scrollController: FixedExtentScrollController(
                    //     initialItem: days.indexOf(selectedDay),
                    //   ),
                    //   onSelectedItemChanged: (index) {
                    //     setState(() {
                    //       selectedDay = days[index];
                    //     });
                    //   },
                    //   children: days
                    //       .map((day) => Center(
                    //             child: Text(
                    //               day,
                    //               style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    //             ),
                    //           ))
                    //       .toList(),
                    // ),
                  ),

                  const SizedBox(width: 20),

                  // Time Picker
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        initialDateTime: _buildInitialDateTime(),
                        onDateTimeChanged: (newDateTime) {
                          setState(() {
                            selectedTime = TimeOfDay.fromDateTime(newDateTime);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Your trade will be opened today at ${selectedTime.format(context)}",
                style: const TextStyle(color: AppColors.buttonDisabled, fontSize: 18,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors:[
                      Color.fromARGB(255,76,238,238),
                      Color.fromARGB(255, 74, 231, 43)
                    ] 
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                        final provider = Provider.of<TradeSettingsProvider>(context, listen: false);
                      provider.setCustomLabels(
                        "Order by time: Today at ${selectedTime.format(context)}",
                        "Profit when ${_controller.text} hit",
                      );

                      Navigator.pop(context); 
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: AppColors.background,fontSize: 20,fontWeight: FontWeight.bold),),
                  ))
              )
            ],
          ),
        ),
        // ),
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

  DateTime _buildInitialDateTime() {
    final now = DateTime.now();
    final date = selectedDay == 'Tomorrow'
        ? DateTime(now.year, now.month, now.day + 1)
        : DateTime(now.year, now.month, now.day);
    return DateTime(date.year, date.month, date.day, selectedTime.hour,
        selectedTime.minute);
  }

}