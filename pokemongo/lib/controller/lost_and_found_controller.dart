import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pokemongo/models/lost_and_found_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LostAndFoundController extends GetxController {
  RxList<LostAndFoundPost> lostFoundPosts = <LostAndFoundPost>[].obs;

  final Dio _dio = Dio(
      BaseOptions(baseUrl: "https://rapid-raptor-slightly.ngrok-free.app/api"));

  @override
  void onInit() {
    super.onInit();
    fetchAllLostAndFound();
  }

  /// Fetch posts from the API
  Future<void> fetchAllLostAndFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      print("Token is null, user not authenticated.");
      return;
    }

    try {
      final response = await _dio.get("/lostandfound/getPost", data: {"token": token});
      print(response);
      if (response.statusCode == 200) {
        var fetchedData = response.data as List;
        lostFoundPosts.assignAll(
            fetchedData.map((e) => LostAndFoundPost.fromJson(e)).toList());
      }
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  void claimItem(int postId) {
    int index = lostFoundPosts.indexWhere((p) => p.postId == postId);
    if (index != -1) {
      lostFoundPosts[index] = lostFoundPosts[index].copyWith(isClaimed: true);
    }
  }
}
