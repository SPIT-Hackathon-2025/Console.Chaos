import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/problems_post_model.dart';

class ProblemPostController extends GetxController {
  var posts = <ProblemPost>[].obs;
  var likedPosts = <int>{}.obs;
  var dislikedPosts = <int>{}.obs;

  final Dio _dio = Dio(BaseOptions(
      baseUrl:
          "https://rapid-raptor-slightly.ngrok-free.app/api")); // Change based on your backend

  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // Fetch posts when the controller is initialized
  }

  /// Fetch posts from the API
  Future<void> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    try {
      print(1);
      final response = await _dio.get("/post", data: {
        "token": token,
      }); // Adjust endpoint accordingly
      print(2);
      // print(response);
      if (response.statusCode == 200) {
        print(3);

        var fetchedData = response.data as List;
        print(fetchedData.map((e) => e["user"]["username"]).toList());
        print(4);

        var postList = fetchedData
            .map((post) => ProblemPost(
                  postId: post['_id']
                      .hashCode, // Using hashCode as a unique identifier
                  username: post["user"]['username'],
                  timeAgo: _formatTimeAgo(post['createdAt']),
                  location: "${post['latitude']}, ${post['longitude']}",
                  content: post['description'] ?? '',
                  imageUrl: post['imgUrl'],
                  likes: post['upvotes'] ?? 0,
                  dislikes: post['downvotes'] ?? 0,
                  comments:
                      0, // Assuming no comments field, you can update this later
                  views: "0", // Placeholder, update as needed
                  tags: List<String>.from(post['tags'] ?? []),
                ))
            .toList();
        print(5);

        posts.assignAll(postList); // Update observable list
      }
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  void likePost(int index) {
    if (likedPosts.contains(index)) {
      posts[index].likes--;
      likedPosts.remove(index);
    } else {
      posts[index].likes++;
      likedPosts.add(index);
      if (dislikedPosts.contains(index)) {
        posts[index].dislikes--;
        dislikedPosts.remove(index);
      }
    }
    update();
  }

  void dislikePost(int index) {
    if (dislikedPosts.contains(index)) {
      posts[index].dislikes--;
      dislikedPosts.remove(index);
    } else {
      posts[index].dislikes++;
      dislikedPosts.add(index);
      if (likedPosts.contains(index)) {
        posts[index].likes--;
        likedPosts.remove(index);
      }
    }
    update();
  }

  String _formatTimeAgo(String dateTimeString) {
    DateTime postTime = DateTime.parse(dateTimeString);
    Duration difference = DateTime.now().difference(postTime);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
}
