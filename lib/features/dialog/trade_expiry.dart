// import 'package:flutter/material.dart';

// void showTradeExpiredDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Trade Expired'),
//           content: const Text('The trade has expired and moved to history.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }




// import 'package:flutter/material.dart';

// void showTradeExpiredDialog(BuildContext context){
//   showDialog(
//     context: context, 
//     builder: (ctx){
//       return AlertDialog(
//         alignment: Alignment.center,
//         title: const Text('Trade Expired'),
//         content: const Text(
//           'The trade has expired and moved to history',
//           style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),
//           actions: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//               height: 54,
//               width: MediaQuery.of(context).size.width / 4,
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 76, 238, 238),
//                     Color.fromARGB(255, 74, 231, 43),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Text(
//                 'Ok',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             )
//           ],
//       );
//     });
// }

