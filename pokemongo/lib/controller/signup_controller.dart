import 'package:get/get.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/pages/nav.dart';
import 'package:pokemongo/service/api_service.dart';
import 'package:pokemongo/service/shared_preferences_service.dart';
import 'package:pokemongo/widgets/snackbar.dart';

class SignupController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  void signup() async {
    print(username.value);
    print(email.value);
    print(password.value);
    if (username.value.isNotEmpty &&
        email.value.isNotEmpty &&
        password.value.isNotEmpty) {
      final response = await apiService.post('/auth/register', body: {
        "email": email.value,
        "username": username.value,
        "password": password.value
      });

      SharedPreferencesService.setString('token', response['token']);
      SharedPreferencesService.setList('user', [response['user']]);

      SharedPreferencesService.getString('token');
      SharedPreferencesService.getList('user');
      SnackbarService.showSuccess(response['message']);

      Get.to(() => NavigationTabs(), transition: Transition.rightToLeft);
    } else {
      SnackbarService.showError("Please enter username and password");
    }
  }
}
