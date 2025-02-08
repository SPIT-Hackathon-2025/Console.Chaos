import 'package:get/get.dart';
import 'package:pokemongo/models/problems_post_model.dart';
import 'package:flutter/material.dart';

class ProblemPostController extends GetxController {
  var posts = <ProblemPost>[].obs;
  var likedPosts = <int>{}.obs; // Track liked posts
  var dislikedPosts = <int>{}.obs; // Track disliked posts

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  void loadPosts() {
    posts.value = [
      ProblemPost(
        username: "John Doe",
        timeAgo: "2h ago",
        location: "New York, USA",
        content: "This is a sample problem description.",
        imageUrl: "assets/problems/problem1.jpeg",
        likes: 10,
        dislikes: 2,
        comments: 5,
        views: "1.2k",
        tags: ["Environment", "Community"],
      ),
      ProblemPost(
        username: "Jane Smith",
        timeAgo: "5h ago",
        location: "London, UK",
        content: "Another sample problem that needs attention.",
        imageUrl: "assets/problems/problem1.jpeg",
        likes: 25,
        dislikes: 1,
        comments: 8,
        views: "2.3k",
        tags: ["Health", "Safety"],
      ),
    ];
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
  
}
