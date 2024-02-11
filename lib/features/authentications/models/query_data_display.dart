// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:haven_glen/features/authentications/models/user.dart';

// class DoneCorrect extends StatefulWidget {
//   const DoneCorrect({super.key});

//   @override
//   State<DoneCorrect> createState() => _DoneCorrectState();
// }

// class _DoneCorrectState extends State<DoneCorrect> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection("CustomerTag")
//           // .doc(UserKK.id)
//           // .collection("Record")
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasData) {
//           final snap = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: snap.length,
//             itemBuilder: (context, index) {
//               return Text(
//                 snap[index]['id'],
//                 style: const TextStyle(
//                   fontSize:
//                       // screenWidth /
//                       18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             },
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
