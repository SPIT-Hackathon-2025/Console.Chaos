import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/post_controller.dart';
import 'package:pokemongo/controller/problem_post_controller.dart';
import 'package:pokemongo/pages/problems/appbar.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/widgets/comments_tree.dart';
import 'package:pokemongo/widgets/problem_post.dart';

class ProblemsPostsPage extends StatelessWidget {
  const ProblemsPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProblemPostController postController =
        Get.put(ProblemPostController());
    final CommentController commentController = Get.put(CommentController());

    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            HomeAppBar(),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: postController.posts.length,
                  itemBuilder: (context, index) {
                    final post = postController.posts[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProblemPostComponent(
                          post: post,
                          index: index,
                          controller: postController,
                        ),
                        Obx(() => commentController.isCommentsVisible(index)
                            ? CommentTreeComponent(postId: index)
                            : SizedBox.shrink()),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
