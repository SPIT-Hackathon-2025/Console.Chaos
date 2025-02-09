import 'package:intl/intl.dart';

class LostAndFoundPost {
  String postId;
  String username;
  String imageUrl;
  String description;
  String location;
  String timeAgo;
  bool isClaimed;
  List<String> tags;

  LostAndFoundPost({
    required this.postId,
    required this.username,
    required this.imageUrl,
    required this.description,
    required this.location,
    required this.timeAgo,
    this.isClaimed = false,
    this.tags = const [],
  });

  factory LostAndFoundPost.fromJson(Map<String, dynamic> json) {
    return LostAndFoundPost(
      postId: json['_id'] ?? 0,
      username: json['user']["username"] ?? '',
      imageUrl: json['imgUrl'] ?? '',
      description: json['description'] ?? '',
      location: json['address'] ?? '',
      timeAgo: json['createdAt'] != null ? DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(json['createdAt'])) : '',
      isClaimed: json['isClaimed'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  LostAndFoundPost copyWith({bool? isClaimed}) {
    return LostAndFoundPost(
      postId: postId,
      username: username,
      imageUrl: imageUrl,
      description: description,
      location: location,
      timeAgo: timeAgo,
      isClaimed: isClaimed ?? this.isClaimed,
      tags: List.from(tags),
    );
  }
}