import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pokemongo/models/community_drives.dart';
import 'package:pokemongo/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityServiceController extends GetxController {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: "https://rapid-raptor-slightly.ngrok-free.app/api"));
  var events = <CommunityDrive>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllEvents();
  }

  Future<void> fetchAllEvents() async {
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      print("Token is null, user not authenticated.");
      isLoading(false);
      return;
    }

    try {
      final response = await _dio.get("/event", data: {"token": token});
      if (response.statusCode == 200) {
        events.value = (response.data as List)
            .map((json) => CommunityDrive.fromJson(json))
            .toList();
      }
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isLoading(false);
    }
  }

  void joinEvent(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    final response = _dio.post("/event/EventMail", data: {
      "token": token,
      "eventId": eventId,
    });
    SnackbarService.showSuccess("Event details will be shared via email");
  }
}
