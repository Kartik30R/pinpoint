// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class RouteScreen extends StatefulWidget {
//   const RouteScreen({super.key});

//   @override
//   State<RouteScreen> createState() => _RouteScreenState();
// }

// class _RouteScreenState extends State<RouteScreen>
//     with TickerProviderStateMixin {
//   late final TabController _tabController;
//   late final List<DateTime> _dates;
//   late int _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     final now = DateTime.now();
//     final start = now.subtract(const Duration(days: 30));
//     final end = now.add(const Duration(days: 1));

//     _dates = List.generate(
//         end.difference(start).inDays + 1, (i) => start.add(Duration(days: i)));

//     _selectedIndex = _dates.indexWhere((d) => isSameDay(d, now));
//     _tabController = TabController(
//         length: _dates.length, vsync: this, initialIndex: _selectedIndex);

//     _tabController.addListener(() {
//       setState(() {
//         _selectedIndex = _tabController.index;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   bool isSameDay(DateTime a, DateTime b) =>
//       a.year == b.year && a.month == b.month && a.day == b.day;

//   @override
//   Widget build(BuildContext context) {
//     final today = DateTime.now();

//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (context, _) => [
//           SliverToBoxAdapter(child: SizedBox(height: 12)),
//           SliverPersistentHeader(
//               pinned: true,
//               delegate: _StickyHeaderDelegate(
//                 height: 90,
//                 child: SizedBox(
//                   height: 90,
//                   child: TabBar(
//                     tabAlignment: TabAlignment.start,
//                     labelPadding: EdgeInsets.only(right: 12),
//                     padding: EdgeInsets.only(left: 12),
//                     controller: _tabController,
//                     indicator: BoxDecoration(),
//                     isScrollable: true,
//                     dividerHeight: 0,
//                     tabs: _dates.map((date) {
//                       final isToday = isSameDay(date, today);
//                       final isSelected =
//                           _tabController.index == _dates.indexOf(date);
//                       return Tab(
//                         height: 70,
//                         child: Material(
//  elevation: 2,
//     borderRadius: BorderRadius.circular(8),
//     shadowColor: Colors.grey.withOpacity(0.5),                          child: Container(
                          
//                             height: 60,
//                             width: 40,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 4, vertical: 8),
//                             decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? Colors.greenAccent
//                                     : Colors.white,
//                                 border: isToday
//                                     ? Border.all(
//                                         color: Colors.greenAccent, width: 1.5)
//                                     : null,
//                                 borderRadius: BorderRadius.circular(6),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       spreadRadius: .05,
//                                       blurRadius: .1,
//                                       color: const Color.fromARGB(
//                                           255, 140, 140, 140),
//                                       offset: Offset(0, 1))
//                                 ]),
//                             child: Center(
//                               child: Text(
//                                 textAlign: TextAlign.center,
//                                 DateFormat('dd MMM').format(date),
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: isSelected
//                                         ? Colors.white
//                                         : Colors.greenAccent),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               )),
//           const SliverToBoxAdapter(child: SizedBox(height: 12)),
//         ],
//         body: TabBarView(
//           controller: _tabController,
//           children: _dates.map((date) {
//             return Center(
//               child: routeTile(date),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// Widget routeTile(DateTime title) {
//   return Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
//   child: Material(
//     elevation: 2,
//     borderRadius: BorderRadius.circular(8),
//     shadowColor: Colors.grey.withOpacity(0.5),
//     child: ExpansionTile(
//       collapsedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       // backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
//       // collapsedBackgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
//       title: Text(
//         DateFormat('EEEE, dd MMM yyyy').format(title),
//         style: const TextStyle(fontSize: 18),
//       ),
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           alignment: Alignment.centerLeft,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Morning', style: TextStyle()),
//               const SizedBox(height: 6),
//               Row(
//                 children: [
//                   const Icon(Icons.verified_rounded),
//                   const SizedBox(width: 4),
//                   const Text('Verified', style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
//                   const SizedBox(width: 24),
//                   const Text('fgfgddf'),
//                   const Spacer(),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.navigate_next_outlined),
//                   )
//                 ],
//               ),
//               const Divider(),
//               const Text('Evening', style: TextStyle()),
//               const SizedBox(height: 6),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Icon(Icons.watch_later_outlined,),
//                   const SizedBox(width: 4),
//                   const Text('Pending', style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
//                   const SizedBox(width: 24,),
//                   const Text('fgfgddf'),
//                   const Spacer(),
//                   Container(
//                     height: 50,
//                     width: 80,
//                     child: ElevatedButton(
// style: ButtonStyle(
//   backgroundColor: WidgetStatePropertyAll(Colors.greenAccent),
//   shape: WidgetStatePropertyAll(
//     RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(4),
//     ),
//   ),
// ),
//                       onPressed: () {},
//                       child: const Text('Verify',style: TextStyle(color: Colors.white),),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   ),
// )
// ;
// }

// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;

//   _StickyHeaderDelegate({required this.child, required this.height});

//   @override
//   double get minExtent => height;
//   @override
//   double get maxExtent => height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Material(
//       elevation: overlapsContent ? 4 : 0,
//       child: child,
//     );
//   }

//   @override
//   bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) => false;
// }
