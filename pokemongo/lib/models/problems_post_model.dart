import 'package:get/get.dart';

class ProblemPost {
  int postId;
  String username;
  String timeAgo;
  String location;
  String content;
  String? imageUrl;
  RxInt likes;
  RxInt dislikes;
  int comments;
  String views;
  List<String> tags;

  ProblemPost({
    required this.postId,
    required this.username,
    required this.timeAgo,
    required this.location,
    required this.content,
    this.imageUrl,
    required int likes,
    required int dislikes,
    required this.comments,
    required this.views,
    required this.tags,
  })  : likes = likes.obs,
        dislikes = dislikes.obs;
}
