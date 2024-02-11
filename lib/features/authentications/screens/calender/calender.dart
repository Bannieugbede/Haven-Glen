import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
// import 'package:get/get.dart';
// import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
// import 'package:haven_glen/features/authentications/models/user.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/features/authentications/screens/search_view/bottom_sheet.dart';
import 'package:haven_glen/features/authentications/screens/search_view/search_view.dart';
import 'package:haven_glen/features/authentications/screens/today_current_info/tag_slider.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  //

  UserModel userDetails = UserModel();

  //
  void _showBottonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        maxChildSize: 0.9,
        minChildSize: 0.32,
        builder: (context, scrollcontroller) => SingleChildScrollView(
          controller: scrollcontroller,
          child: SliderContent(),
        ),
      ),
    );
  }

  //

  String _month = DateFormat('MMMM').format(DateTime.now());
  //
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final controller = UserController.instance;
    // final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Client Check In/Out Attendance'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _month,
                  style: TextStyle(
                    fontSize: screenWidth / 18,
                  ),
                ),
                // SearchView(),
                // TextButton.icon(
                //     onPressed: () async {
                //       final month = await showMonthYearPicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(2024),
                //           lastDate: DateTime(2099),
                //           builder: (context, child) {
                //             return Theme(
                //               data: Theme.of(context).copyWith(
                //                 colorScheme: const ColorScheme.light(
                //                   primary: ZColors.primary,
                //                   secondary: ZColors.primary,
                //                   onSecondary: ZColors.white,
                //                 ),
                //                 textButtonTheme: TextButtonThemeData(
                //                   style: TextButton.styleFrom(
                //                       foregroundColor: ZColors.primary),
                //                 ),
                //                 textTheme: const TextTheme(
                //                   headlineMedium:
                //                       TextStyle(fontWeight: FontWeight.bold),
                //                   labelSmall:
                //                       TextStyle(fontWeight: FontWeight.bold),
                //                   labelLarge:
                //                       TextStyle(fontWeight: FontWeight.bold),
                //                 ),
                //               ),
                //               child: child!,
                //             );
                //           });

                //       //
                //       if (month != null) {
                //         setState(() {
                //           _month = DateFormat('MMMM').format(month);
                //         });
                //       }
                //       // logoutClient();
                //     },
                //     icon: const Icon(Iconsax.calendar_edit,
                //         color: ZColors.primary),
                //     label: const Text(
                //       'Pick a Month',
                //       style: TextStyle(color: ZColors.primary),
                //     )),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: screenHeight / 1.5,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("CustomerTag")
                    .doc(AuthenticationRepository.instance.authUser?.uid)
                    // .doc(UserKK.id)
                    .collection("Record")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return DateFormat('MMMM')
                                    .format(snap[index]['date'].toDate()) ==
                                _month
                            ? Slidable(
                                startActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: ((context) {}),
                                      // onPressed: ((context) {}),
                                      icon: Iconsax.trash,
                                      backgroundColor: Colors.red,
                                      label: 'Delete Record',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) async {
                                        await controller.uploadUserProfilePic();
                                      },
                                      // onPressed: ((context) {}),
                                      icon: Iconsax.camera,
                                      backgroundColor: Colors.green,
                                      label: 'Capture',
                                    ),
                                    SlidableAction(
                                      onPressed: ((context) {
                                        _showBottonSheet(context);
                                      }),
                                      icon: Iconsax.send,
                                      backgroundColor: Colors.yellow,
                                      label: 'Action',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: index > 0 ? 12 : 0,
                                      left: 6,
                                      right: 6),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: ZColors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(2, 2)),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //
                                      Expanded(
                                        child: FullScreenWidget(
                                          disposeLevel: DisposeLevel.High,
                                          child: Container(
                                            margin: const EdgeInsets.only(),
                                            decoration: BoxDecoration(
                                              color: ZColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              // child: Text(
                                              //   // DateFormat('EE\ndd').format(
                                              //   //     snap[index]['date']
                                              //   //         .toDate()),
                                              //   'ID:\n0001',
                                              //   style: TextStyle(
                                              //       fontSize: screenWidth / 18,
                                              //       fontWeight: FontWeight.w500,
                                              //       color: ZColors.white),
                                              // ),
                                              child: Image.network(
                                                  fit: BoxFit.fill,
                                                  '${controller.user.value.profilePicture}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Entry',
                                              style: TextStyle(
                                                  fontSize: screenWidth / 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.green),
                                            ),
                                            Text(
                                              snap[index]['checkIn'],
                                              style: TextStyle(
                                                  fontSize: screenWidth / 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            //
                                            Text(
                                              DateFormat('EE dd yyyy').format(
                                                  snap[index]['date'].toDate()),
                                              style: TextStyle(
                                                fontSize: screenWidth / 25,
                                                fontWeight: FontWeight.w400,
                                                // color: ZColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Exit',
                                              style: TextStyle(
                                                  fontSize: screenWidth / 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              snap[index]['checkOut'],
                                              style: TextStyle(
                                                  fontSize: screenWidth / 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            //
                                            Text(
                                              DateFormat('EE dd yyyy').format(
                                                  snap[index]['date'].toDate()),
                                              style: TextStyle(
                                                fontSize: screenWidth / 25,
                                                fontWeight: FontWeight.w400,
                                                // color: ZColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
