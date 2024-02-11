import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/controllers/network_manager.dart';

class GeneralBindings extends Bindings {
  
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
  }
}
