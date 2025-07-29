// import 'package:flutter/material.dart';
// import 'package:pinpoint/resources/constant/color/app_color.dart';
// import 'package:pinpoint/view/user/profile/ProfileSetting.dart';
// import 'package:pinpoint/view/user/profile/altitude.dart';
// import 'package:pinpoint/view/user/profile/locationHistory.dart';

// class UserprofileScreen extends StatelessWidget {
//   const UserprofileScreen({super.key});


// final String name ="";
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Column(
//         spacing: 10,
//         children: [
//           SizedBox(height: 30,),
//           Text(name, style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColor.primary,fontWeight: FontWeight.w900),),
//           SizedBox(height: 10,),
//           GestureDetector(onTap:() {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetting()));
//           },child: Text("Profile", style: Theme.of(context).textTheme.headlineMedium)),
//           GestureDetector(onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context)=> AltitudeSet()));
//           },child: Text("Set Altitude", style: Theme.of(context).textTheme.headlineMedium)),
//           GestureDetector(onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>Locationhistory()));
//           },child: Text("Location History", style: Theme.of(context).textTheme.headlineMedium)),
//         ],
//       ),
//     );


//   }
// }

