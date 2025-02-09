import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/problem_post_controller.dart';
import 'package:pokemongo/models/problems_post_model.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/widgets/lost_and_found_post.dart';
import 'package:pokemongo/widgets/open_drives_post.dart';
import 'package:pokemongo/widgets/problem_post.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                print('Logged out');
              },
            ),
          ],
          backgroundColor: bgcolor,
          title: const Text('Profile', style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            dividerHeight: 0,
            labelColor: Colors.redAccent,
            indicatorColor: Colors.redAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on_sharp),
              ),
              Tab(
                icon: Icon(Icons.question_mark_sharp),
              ),
              Tab(
                icon: Icon(Icons.people_sharp),
              ),
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: const TabBarView(
            children: [
              MyPostsTab(),
              LostAndFoundTab(),
              CommunityServiceTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPostsTab extends StatelessWidget {
  const MyPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ProblemPostController controller = Get.put(ProblemPostController());
    return Obx(() => ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return ProblemPostComponent(
              post: controller.posts[index],
              index: index,
              controller: controller,
            );
          },
        ));
  }
}

class LostAndFoundTab extends StatelessWidget {
  const LostAndFoundTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of items
      itemBuilder: (context, index) {
        return LostFoundItem(
          isClaimed: true.obs,
          username: "Jainam Barbhaya",
          isOwner: true,
          imageUrl: "assets/problems/problem1.jpeg",
          description: 'found a Charizard at the park',
          location: 'Mumbai, Maharashtra, India',
          timeFound: '${index + 1} hours ago',
          onClaim: () {
            print('Claimed item $index');
          },
        );
      },
    );
  }
}

class CommunityServiceTab extends StatelessWidget {
  const CommunityServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with the actual number of items
      itemBuilder: (context, index) {
        return CommunityDriveCard(
          isOrganizer: true,
          imageUrl: 'assets/problems/problem1.jpeg',
          location: 'Location $index',
          title: 'Community Drive $index',
          time: 'Time $index',
          onRsvp: () {
            print('RSVP clicked for drive $index!');
          },
        );
      },
    );
  }
}
