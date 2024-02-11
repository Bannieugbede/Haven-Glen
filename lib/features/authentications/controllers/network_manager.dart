import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haven_glen/utils/helpers/snack_bar_dialog.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  //
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscribtion;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  //
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscribtion =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // update the connection
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      SnackBarDialog.warningSnackBar(title: 'No Internet Connection');
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  // dispose
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscribtion.cancel();
  }
}
