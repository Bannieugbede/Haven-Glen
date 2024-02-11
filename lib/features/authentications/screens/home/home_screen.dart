import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
// import 'package:haven_glen/features/authentications/models/user.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/features/authentications/screens/calender/calender.dart';
import 'package:haven_glen/features/authentications/screens/profile/profile.dart';
import 'package:haven_glen/features/authentications/screens/today_current_info/today_current_info.dart';
import 'package:haven_glen/features/localization/location_service.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  //

  int currentIndex = 1;

  UserModel userDetails = UserModel();

  // Menu Icons
  List<IconData> navIcons = [
    Iconsax.calendar,
    Iconsax.home,
    Iconsax.user,
  ];

  //
  List iconText = ["Calender", "Home", "Profile"];

  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startLocationService();
    getId().then((value) {
//
      _getCredentials();
      _getProfilePic();
    });
  }

  void _getCredentials() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("CustomerTag")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      //
      setState(() {
      });
    } catch (e) {
      return;
    }
  }

  //
  void _getProfilePic() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("CustomerTag")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .get();
    //
    setState(() {
      userDetails.profilePicture = doc['ProfilePicture'];
    });
  }

  //
  void _startLocationService() async {
    LocationService().initialize();

    //
    LocationService().getLongitude().then((value) {
      setState(() {
        UserModel.long = value!;
      });
      //
      LocationService().getLatitude().then((value) {
        setState(() {
          UserModel.lat = value!;
          // UserKK.lat = value!;
        });
      });
      //
    });
  }

  //
  Future<void> getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("CustomerTag")
        .where('id', isEqualTo: userDetails.emailId)
        .get();

    setState(() {
      userDetails.clientId = snap.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          new CalenderScreen(),
          new ClientCurrentInfoScreen(),
          new ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
        decoration: BoxDecoration(
          color: ZColors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < navIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: ZColors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              navIcons[i],
                              color: i == currentIndex
                                  ? ZColors.primary
                                  : ZColors.grey,
                              size: i == currentIndex ? 30 : 25,
                            ),
                            Text(
                              iconText[i],
                              style: TextStyle(
                                color: i == currentIndex
                                    ? ZColors.primary
                                    : ZColors.grey,
                                fontSize: i == currentIndex ? 15 : 12,
                              ),
                            ),
                            i == currentIndex
                                ? Container(
                                    margin: const EdgeInsets.only(
                                      top: 3,
                                      bottom: 2,
                                    ),
                                    height: 4,
                                    width: 22,
                                    decoration: const BoxDecoration(
                                        color: ZColors.primary),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
