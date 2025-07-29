// import 'package:flutter/material.dart';
// import 'package:pinpoint/resources/constant/color/app_color.dart';
// import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';
// import 'package:pinpoint/view/user/userProfile.dart';
// import 'package:pinpoint/view/user/userHome.dart';
// import 'package:pinpoint/viewModel/bottomNavigationController.dart';
// import 'package:provider/provider.dart';

// class UserScreen extends StatelessWidget {
//   const UserScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: Consumer<BottomNavigationBarController>(
//         builder: (context, bottomNavProvider, child) {
//           switch (bottomNavProvider.currentIndex) {
//             case 0:
//               return UserHomeScreen();
//             case 1:
//               return UserprofileScreen();
//             default:
//               return UserHomeScreen(); 
//           }
//         },
//       ),
//      bottomNavigationBar: Consumer<BottomNavigationBarController>(
//   builder: (context, bottomNavProvider, child) {
//     return Padding(
//               padding: EdgeInsets.only(bottom: AppDimension().defaultMargin,left:  AppDimension().defaultMargin,right: AppDimension().defaultMargin),

//       child: Container(
//         decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 255, 255, 255),
//                 border: Border.all(color: AppColor.dark,width:1,),
//                 boxShadow: [BoxShadow(offset: Offset(4, 4),color: AppColor.dark)],
//                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20))
      
//         ),
//         height: 60,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: Icon(
//                 Icons.home,
//                 color: bottomNavProvider.currentIndex == 0 ? Colors.white : Colors.grey,
//               ),
//               onPressed: () => bottomNavProvider.updateCurrentIndex(0),
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.search,
//                 color: bottomNavProvider.currentIndex == 1 ? Colors.white : Colors.grey,
//               ),
//               onPressed: () => bottomNavProvider.updateCurrentIndex(1),
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.account_circle,
//                 color: bottomNavProvider.currentIndex == 2 ? Colors.white : Colors.grey,
//               ),
//               onPressed: () => bottomNavProvider.updateCurrentIndex(2),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// ),

//     );
//   }
// }