import 'package:get/get.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/pages/nav.dart';
import 'package:pokemongo/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void login() async {
    print(email.value);
    print(password.value);
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
      final response = await apiService.post('/auth/login',
          body: {"email": email.value, "password": password.value});

      print(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['token']);

      

      String? token = prefs.getString('token');

      print(token);
      SnackbarService.showSuccess(response['message']);
      Get.to(() => NavigationTabs(), transition: Transition.rightToLeft);
    } else {
      SnackbarService.showError("Please enter username and password");
    }
  }
}
