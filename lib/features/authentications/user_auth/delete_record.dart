import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
import 'package:haven_glen/utils/constants/sizes.dart';

class DeleteRecord extends StatefulWidget {
  const DeleteRecord({super.key});

  @override
  State<DeleteRecord> createState() => _DeleteRecordState();
}

class _DeleteRecordState extends State<DeleteRecord> {
   static DeleteRecord get instance => Get.find();
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ZSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () => controllerDel.deleteUserAccount(),
        // Replace 'userIdToDelete' with the actual user's document ID
        //   await deleteUserAccount();

        // },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: ZSizes.lg),
            child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }
  // 
   final controllerDel = Get.put(UserController());

   final controllerDelete = Get.put(DeleteRecord());
  // 

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}