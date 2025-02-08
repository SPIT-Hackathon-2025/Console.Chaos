import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/problem_post_controller.dart';
import 'package:pokemongo/pages/problems/appbar.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/widgets/problem_post.dart';

class ProblemsPostsPage extends StatelessWidget {
  const ProblemsPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProblemPostController controller = Get.put(ProblemPostController());
    
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const HomeAppBar(),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return ProblemPostComponent(
                      post: controller.posts[index],
                      index: index,
                      controller: controller,
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
