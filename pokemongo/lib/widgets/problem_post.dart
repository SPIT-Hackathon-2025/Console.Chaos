import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/problem_post_controller.dart';
import 'package:pokemongo/models/problems_post_model.dart';

class ProblemPostComponent extends StatelessWidget {
  final ProblemPost post;
  final int index;
  final ProblemPostController controller;

  const ProblemPostComponent({
    super.key,
    required this.post,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/problems/problem1.jpeg'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        post.timeAgo,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.circle, color: Colors.grey, size: 5),
                      const SizedBox(width: 10),
                      Text(
                        post.location,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            post.content,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          if (post.imageUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(post.imageUrl!, width: double.infinity, fit: BoxFit.cover,),
            ),
          Wrap(
            spacing: 8.0,
            children: post.tags
                .map((tag) => Text(
                      "#$tag",
                      style: const TextStyle(color: Colors.blueAccent),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          Obx(() => Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.thumb_up,
                color: controller.likedPosts.contains(index) ? Colors.blue : Colors.grey,
              ),
              onPressed: () => controller.likePost(index),
            ),
            Text('${post.likes.value}', style: const TextStyle(color: Colors.grey)),
            IconButton(
              icon: Icon(
                Icons.thumb_down,
                color: controller.dislikedPosts.contains(index) ? Colors.red : Colors.grey,
              ),
              onPressed: () => controller.dislikePost(index),
            ),
            Text('${post.dislikes.value}', style: const TextStyle(color: Colors.grey)),
            const Spacer(),
            Text('${post.views} views', style: const TextStyle(color: Colors.grey)),
            const Icon(Icons.show_chart_sharp, color: Colors.green, size: 18),
            const Spacer(),
            const Icon(Icons.chat_bubble_outline, color: Colors.grey),
            const SizedBox(width: 4),
            Text('${post.comments}', style: const TextStyle(color: Colors.grey)),
          ],
        ))
        ],
      ),
    );
  }
}
