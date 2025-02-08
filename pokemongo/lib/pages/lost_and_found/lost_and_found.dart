import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/lost_and_found_controller.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/pages/lost_and_found/lost_And_found_appbar.dart';
import 'package:pokemongo/widgets/lost_and_found_post.dart';

class LostAndFound extends StatelessWidget {
  final LostAndFoundController lostAndFoundController =
      Get.put<LostAndFoundController>(LostAndFoundController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            LostAndFoundAppBar(),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: lostAndFoundController.lostFoundPosts.length,
                  itemBuilder: (context, index) {
                    final post = lostAndFoundController.lostFoundPosts[index];
                    return LostFoundItem(
                      username: post.username,
                      isOwner: false,
                      imageUrl: post.imageUrl,
                      description: post.description,
                      location: post.location,
                      timeFound: post.timeAgo,
                      onClaim: () {
                        
                        Get.snackbar("Claimed", "You have claimed this item!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.blue,
                            colorText: Colors.white);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
