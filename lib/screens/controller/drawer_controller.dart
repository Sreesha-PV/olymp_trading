// // GetX Controller to manage drawer visibility
// import 'package:get/get.dart';

// class DrawerController extends GetxController {
//   var isAccountDrawerOpen = false.obs;
//   var isPaymentDrawerOpen = false.obs;

//   // Toggles the visibility of Account Drawer
//   void toggleAccountDrawer() {
//     isAccountDrawerOpen.value = !isAccountDrawerOpen.value;
//     if (isAccountDrawerOpen.value) {
//       isPaymentDrawerOpen.value = false; // Close Payment Drawer when Account is opened
//     }
//   }

//   // Toggles the visibility of Payment Drawer
//   void togglePaymentDrawer() {
//     isPaymentDrawerOpen.value = !isPaymentDrawerOpen.value;
//     if (isPaymentDrawerOpen.value) {
//       isAccountDrawerOpen.value = false; // Close Account Drawer when Payment is opened
//     }
//   }
// }




// import 'package:get/get.dart';

// class DrawerController extends GetxController {
//   var selectedIndex = -1.obs;
//   var isAccountDrawerOpen = false.obs;
//   var isPaymentDrawerOpen = false.obs;

//   // Update selected index
//   void updateSelectedIndex(int index) {
//     selectedIndex.value = index;
//   }

//   // Open or close account drawer
//   void toggleAccountDrawer() {
//     isAccountDrawerOpen.value = !isAccountDrawerOpen.value;
//   }

//   // Open or close payment drawer
//   void togglePaymentDrawer() {
//     isPaymentDrawerOpen.value = !isPaymentDrawerOpen.value;
//   }
// }


