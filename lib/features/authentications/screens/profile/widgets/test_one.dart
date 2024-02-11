// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:haven_glen/features/authentications/models/user.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Real-Time Updates with StreamBuilder'),
// //         ),
// //         body: StreamBuilder(
// //           stream: FirebaseFirestore.instance.collection("CustomerTag").snapshots(),
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return CircularProgressIndicator(); // Loading state
// //             } else if (snapshot.hasError) {
// //               return Text('Error: ${snapshot.error}'); // Error state
// //             } else {
// //               if(snapshot.connectionState == ConnectionState.active || snapshot.hasData) {
// //               // Data available state
// //               List<DocumentSnapshot> documents = snapshot.data!.docs;
// //               return ListView.builder(
// //                 itemCount: snapshot.data!.docs.length,
// //                 itemBuilder: (context, index) {
// //                   // Build your UI using the document data
// //                   return Column(children: [Text(snapshot.data!.docs.elementAt(index)['id'])],);
// //                 },
// //               );

// //               }
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:haven_glen/features/authentications/models/user.dart';
// import 'package:haven_glen/utils/constants/colors.dart';
// import 'package:intl/intl.dart';
// import 'package:slide_to_act/slide_to_act.dart';

// class ProfileNamePage extends StatefulWidget {
//   final String userId; // Pass the user ID to fetch the data

//   ProfileNamePage({required this.userId});

//   @override
//   State<ProfileNamePage> createState() => _ProfileNamePageState();
// }

// class _ProfileNamePageState extends State<ProfileNamePage> {
//   double screenHeight = 0;
//   double screenWidth = 0;

//   String checkIn = "--/--";
//   String checkOut = "--/--";
//   String location = "";
//   //
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getRecord();
//   }

//   void _getLocation() async {
//     List<Placemark> placemark =
//         await placemarkFromCoordinates(User.lat, User.long);

//     setState(() {
//       location =
//           "${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}, ${placemark[0].country}";
//     });
//   }

//   void _getRecord() async {
//     try {
//       QuerySnapshot snap = await FirebaseFirestore.instance
//           .collection("CustomerTag")
//           .where('id', isEqualTo: User.customerTagID)
//           .get();

//       DocumentSnapshot snap2 = await FirebaseFirestore.instance
//           .collection("CustomerTag")
//           .doc(snap.docs[0].id)
//           .collection("Record")
//           .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
//           .get();

//       setState(() {
//         checkIn = snap2['checkIn'];
//         checkOut = snap2['checkOut'];
//       });
//     } catch (e) {
//       setState(() {
//         checkIn = "--/--";
//         checkOut = "--/--";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Name Page'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("CustomerTag")
//             .doc()
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }

//           var profileData = snapshot.data;

//           // return Center(
//           //   child: Text('Profile Name: ${profileData!['name']}'),
//           // );
//           return Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(top: 40),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'WELCOME',
//                   style: TextStyle(
//                     fontSize: screenWidth / 18,
//                   ),
//                 ),
//               ),
//               // ZProfileMenu(
//               //   title: 'Client Name:',
//               //   value: User.userName,
//               // ),
//               Container(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Client ID: ${profileData!['id']}",
//                     style: TextStyle(
//                         fontSize: screenWidth / 15,
//                         fontWeight: FontWeight.bold)),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 30),
//                 alignment: Alignment.centerLeft,
//                 child: Text("Today's Status",
//                     style: TextStyle(
//                         fontSize: screenWidth / 18,
//                         fontWeight: FontWeight.bold)),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 12, bottom: 32),
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: ZColors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10,
//                         offset: Offset(2, 2)),
//                   ],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Check In',
//                             style: TextStyle(
//                                 fontSize: screenWidth / 20,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black54),
//                           ),
//                           Text(
//                             checkIn,
//                             style: TextStyle(
//                                 fontSize: screenWidth / 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Check Out',
//                             style: TextStyle(
//                                 fontSize: screenWidth / 20,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black54),
//                           ),
//                           Text(
//                             checkOut,
//                             style: TextStyle(
//                                 fontSize: screenWidth / 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.centerLeft,
//                 child: RichText(
//                   text: TextSpan(
//                     text: DateTime.now().day.toString(),
//                     style: TextStyle(
//                         fontSize: screenWidth / 18,
//                         fontWeight: FontWeight.bold,
//                         color: ZColors.primary),
//                     children: [
//                       TextSpan(
//                         text: DateFormat(' MMMM yyyy').format(DateTime.now()),
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: screenWidth / 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               StreamBuilder(
//                   stream: Stream.periodic(const Duration(seconds: 1)),
//                   builder: (context, snapshot) {
//                     return Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         DateFormat('hh:mm:ss a').format(DateTime.now()),
//                         style: TextStyle(
//                             fontSize: screenWidth / 20,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black54),
//                       ),
//                     );
//                   }),
//               checkOut == "--/--"
//                   ? Container(
//                       margin: const EdgeInsets.only(top: 24, bottom: 12),
//                       child: Builder(builder: (context) {
//                         final GlobalKey<SlideActionState> key = GlobalKey();

//                         //
//                         return SlideAction(
//                           text: checkIn == "--/--"
//                               ? "Slide to Check In"
//                               : "Slide to Check Out",
//                           textStyle: TextStyle(
//                             color: Colors.black54,
//                             fontSize: screenWidth / 20,
//                           ),
//                           outerColor: ZColors.white,
//                           innerColor: ZColors.primary,
//                           key: key,
//                           onSubmit: () async {
//                             if (User.lat != 0) {
//                               _getLocation();
//                               //
//                               QuerySnapshot snap = await FirebaseFirestore
//                                   .instance
//                                   .collection("CustomerTag")
//                                   .where('id', isEqualTo: User.customerTagID)
//                                   .get();

//                               DocumentSnapshot snap2 = await FirebaseFirestore
//                                   .instance
//                                   .collection("CustomerTag")
//                                   .doc(snap.docs[0].id)
//                                   .collection("Record")
//                                   .doc(DateFormat('dd MMMM yyyy')
//                                       .format(DateTime.now()))
//                                   .get();

//                               try {
//                                 String checkIn = snap2['checkIn'];
//                                 //
//                                 setState(() {
//                                   checkOut = DateFormat('hh:mm a')
//                                       .format(DateTime.now());
//                                 });
//                                 //
//                                 await FirebaseFirestore.instance
//                                     .collection("CustomerTag")
//                                     .doc(snap.docs[0].id)
//                                     .collection("Record")
//                                     .doc(DateFormat('dd MMMM yyyy')
//                                         .format(DateTime.now()))
//                                     .update({
//                                   'date': Timestamp.now(),
//                                   'checkIn': checkIn,
//                                   'checkOut': DateFormat('hh:mm a')
//                                       .format(DateTime.now()),
//                                   'checkInLocation': location,
//                                 });
//                               } catch (e) {
//                                 setState(() {
//                                   checkIn = DateFormat('hh:mm a')
//                                       .format(DateTime.now());
//                                 });
//                                 //
//                                 await FirebaseFirestore.instance
//                                     .collection("CustomerTag")
//                                     .doc(snap.docs[0].id)
//                                     .collection("Record")
//                                     .doc(DateFormat('dd MMMM yyyy')
//                                         .format(DateTime.now()))
//                                     .set({
//                                   'date': Timestamp.now(),
//                                   'checkIn': DateFormat('hh:mm a')
//                                       .format(DateTime.now()),
//                                   'checkOut': "--/--",
//                                   'checkOutLocation': location,
//                                 });
//                               }

//                               key.currentState!.reset();

//                               //
//                             } else {
//                               Timer(const Duration(seconds: 3), () async {
//                                 _getLocation();
//                                 //
//                                 QuerySnapshot snap = await FirebaseFirestore
//                                     .instance
//                                     .collection("CustomerTag")
//                                     .where('id', isEqualTo: User.customerTagID)
//                                     .get();

//                                 DocumentSnapshot snap2 = await FirebaseFirestore
//                                     .instance
//                                     .collection("CustomerTag")
//                                     .doc(snap.docs[0].id)
//                                     .collection("Record")
//                                     .doc(DateFormat('dd MMMM yyyy')
//                                         .format(DateTime.now()))
//                                     .get();

//                                 try {
//                                   String checkIn = snap2['checkIn'];
//                                   //
//                                   setState(() {
//                                     checkOut = DateFormat('hh:mm a')
//                                         .format(DateTime.now());
//                                   });
//                                   //
//                                   await FirebaseFirestore.instance
//                                       .collection("CustomerTag")
//                                       .doc(snap.docs[0].id)
//                                       .collection("Record")
//                                       .doc(DateFormat('dd MMMM yyyy')
//                                           .format(DateTime.now()))
//                                       .update({
//                                     'date': Timestamp.now(),
//                                     'checkIn': checkIn,
//                                     'checkOut': DateFormat('hh:mm a')
//                                         .format(DateTime.now()),
//                                     'checkInLocation': location,
//                                   });
//                                 } catch (e) {
//                                   setState(() {
//                                     checkIn = DateFormat('hh:mm a')
//                                         .format(DateTime.now());
//                                   });
//                                   //
//                                   await FirebaseFirestore.instance
//                                       .collection("CustomerTag")
//                                       .doc(snap.docs[0].id)
//                                       .collection("Record")
//                                       .doc(DateFormat('dd MMMM yyyy')
//                                           .format(DateTime.now()))
//                                       .set({
//                                     'date': Timestamp.now(),
//                                     'checkIn': DateFormat('hh:mm a')
//                                         .format(DateTime.now()),
//                                     'checkOut': "--/--",
//                                     'checkOutLocation': location,
//                                   });
//                                 }

//                                 key.currentState!.reset();
//                               });
//                             }
//                           },
//                         );
//                       }),
//                     )
//                   : Container(
//                       margin: const EdgeInsets.only(top: 32, bottom: 32),
//                       child: Text(
//                         "You have completed this day",
//                         style: TextStyle(
//                             fontSize: screenWidth / 20,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black54),
//                       ),
//                     ),
//               location != " "
//                   ? Text(
//                       "Location: $location",
//                     )
//                   : const SizedBox(),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyController extends GetxController {
  RxList<DocumentSnapshot> documents = <DocumentSnapshot>[].obs;

  void getDataFromFirestore() {
    FirebaseFirestore.instance
        .collection('CustomerTag')
        .snapshots()
        .listen((snapshot) {
      documents.assignAll(snapshot.docs);
    });
  }
}
