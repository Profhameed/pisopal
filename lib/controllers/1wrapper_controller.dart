import 'package:get/get.dart';
import 'package:inbestment/data/models/user_model.dart';
import 'package:inbestment/data/repository.dart';
import 'package:inbestment/data/sqlite/sqlite_respository.dart';
import 'package:inbestment/shared/auth_manager.dart';

class WrapperController extends GetxController {
  late AuthManager authManager;
  UserModel? userModel;
  late Repository repository;

  @override
  void onInit() async {
    super.onInit();
    authManager = await Get.putAsync(() => AuthManager().init());
    repository = Get.put(SqliteRepository());
    await repository.init();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    if (authManager.isLogged) {
      await fetchUser();
    }
  }

  Future<void> fetchUser() async {
    userModel = await repository.getUserWithToken(authManager.token ?? '0');
    if (userModel == null) {
      authManager.logOut();
      return;
    }
    Get.offAllNamed('/homePage', arguments: userModel);
  }
}
