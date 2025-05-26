// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class DateTimePickerDemo extends StatefulWidget {
//   const DateTimePickerDemo({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DateTimePickerDemoState createState() => _DateTimePickerDemoState();
// }

// class _DateTimePickerDemoState extends State<DateTimePickerDemo> {
//   DateTime selectedDateTime = DateTime.now();

//   void _showPicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return SizedBox(
//           height: 250,
//           child: CupertinoDatePicker(
//             mode: CupertinoDatePickerMode.dateAndTime,
//             initialDateTime: selectedDateTime,
//             onDateTimeChanged: (DateTime newDateTime) {
//               setState(() {
//                 selectedDateTime = newDateTime;
//               });
//             },
//             use24hFormat: true,
//           ),
//         );
//       },
//     );
//   }  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Date & Time Picker")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Selected: ${selectedDateTime.toLocal()}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _showPicker(context),
//               child: const Text("Pick Date & Time"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/core/constants/app_colors.dart';

// class TimeSelectionScreen extends StatefulWidget {
//   const TimeSelectionScreen({super.key});

//   @override
//   State<TimeSelectionScreen> createState() => _TimeSelectionScreenState();
// }

// class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
//   String selectedDay = 'Today';
//   TimeOfDay selectedTime = TimeOfDay.now();

//   List<String> days = ['Today', 'Tomorrow'];
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Row(
//         //   children: [
//             // _buildFilterChip('Any Profitability', width: 140),
//             // const SizedBox(width: 10),
//             // _buildFilterChip('from 70%', width: 100),
//             // const SizedBox(width: 10),
//             // _buildFilterChip('from 80%', width: 100),
//         //   ],
//         // ),
//         Container(
//           width: 100,
//           color: Colors.grey[900],
//           child: ListView.builder(
//             itemCount: days.length,
//             itemBuilder: (context, index) {
//               String day = days[index];
//               bool isSelected = selectedDay == day;

//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedDay = day;
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   color: isSelected ? Colors.greenAccent : Colors.transparent,
//                   child: Center(
//                     child: Text(
//                       day,
//                       style: TextStyle(
//                         color: isSelected ? Colors.black : Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Expanded(
//           child: Container(
//             color: Colors.black,
//             child: CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.time,
//               use24hFormat: true,
//               initialDateTime: _buildInitialDateTime(),
//               onDateTimeChanged: (DateTime newTime) {
//                 setState(() {
//                   selectedTime = TimeOfDay.fromDateTime(newTime);
//                 });
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   DateTime _buildInitialDateTime() {
//     DateTime now = DateTime.now();
//     if (selectedDay == 'Tomorrow') {
//       return DateTime(now.year, now.month, now.day + 1, now.hour, now.minute);
//     } else {
//       return now;
//     }
//   }
//   }




// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/core/constants/app_colors.dart';

// class TimeSelectionScreen extends StatefulWidget {
//   const TimeSelectionScreen({super.key});

//   @override
//   State<TimeSelectionScreen> createState() => _TimeSelectionScreenState();
// }

// class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
//   String selectedDay = 'Today';
//   TimeOfDay selectedTime = TimeOfDay.now();
//   DateTime selectedDateTime = DateTime.now();

//   List<String> days = ['Today', 'Tomorrow'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     backgroundColor: Colors.black,
//     body: SafeArea(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   _buildFilterChip('Any Profitability', width: 140),
//                     const SizedBox(width: 10),
//                   _buildFilterChip('from 70%', width: 100),
//                   const SizedBox(width: 10),
//                   _buildFilterChip('from 80%', width: 100),
//                   const SizedBox(height: 10,), 
//                 ],
//               ),

//                SizedBox(
//               height: 200,
//               child: CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.dateAndTime,
//               initialDateTime: selectedDateTime,
//               onDateTimeChanged: (DateTime newDateTime){
//                 setState(() {
//                   selectedDateTime = newDateTime;
//                 });
//               },
//               use24hFormat: true,
//               ),
//         ),
//            ],
//           ),
//         ),
//       ),
//     ),
//   );
//   }

//   Widget _buildFilterChip(String text, {required double width}) {
//     return Container(
//       width: width,
//       height: 40,
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10),
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 15, color: AppColors.textColor),
//           ),
//         ),
//       ),
//     );
//   }

//   DateTime _buildInitialDateTime() {
//     DateTime now = DateTime.now();
//     if (selectedDay == 'Tomorrow') {
//       return DateTime(now.year, now.month, now.day + 1, now.hour, now.minute);
//     } else {
//       return now;
//     }
//   }
//   }





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

class TimeSelectionScreen extends StatefulWidget {
  const TimeSelectionScreen({super.key});

  @override
  State<TimeSelectionScreen> createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  String selectedDay = 'Today';
  TimeOfDay selectedTime = TimeOfDay.now();

  List<String> days = ['Today', 'Tomorrow'];

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
                  ],
                ),
                const SizedBox(height: 20),
                // Day toggle
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: days.map((day) {
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //       child: ChoiceChip(
                //         label: Text(day),
                //         selected: selectedDay == day,
                //         onSelected: (_) {
                //           setState(() {
                //             selectedDay = day;
                //           });
                //         },
                //         selectedColor: Colors.green,
                //         labelStyle: TextStyle(
                //           color: selectedDay == day ? Colors.black : Colors.white,
                //         ),
                //         backgroundColor: Colors.grey.shade800,
                //       ),
                //     );
                //   }).toList(),
                // ),
                const SizedBox(height: 20),
                // Time picker only
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: _buildInitialDateTime(),
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() {
                        selectedTime = TimeOfDay.fromDateTime(newTime);
                      });
                    },
                    use24hFormat: true,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Selected: $selectedDay at ${selectedTime.format(context)}",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )
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

  DateTime _buildInitialDateTime() {
    final now = DateTime.now();
    final date = selectedDay == 'Tomorrow'
        ? DateTime(now.year, now.month, now.day + 1)
        : DateTime(now.year, now.month, now.day);
    return DateTime(date.year, date.month, date.day, selectedTime.hour, selectedTime.minute);
  }
}


