import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';

void orderSuccessDialog(BuildContext context){
  showDialog(
    context: context, 
    builder: (ctx){
      return AlertDialog(
        alignment: Alignment.center,
        content: const Text(
          'Order placed successfully',
          style: TextStyle(color: AppColors.success,fontSize: 16,fontWeight: FontWeight.bold),),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
              height: 54,
              width: MediaQuery.of(context).size.width / 4,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 76, 238, 238),
                    Color.fromARGB(255, 74, 231, 43),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Ok',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            )
          ],
      );
    });
}

