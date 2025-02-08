import 'package:flutter/material.dart';
import 'package:pokemongo/pages/problems/appbar.dart';
import 'package:pokemongo/themes.dart';
import 'package:pokemongo/widgets/problem_post.dart';

class ProblemsPostsPage extends StatelessWidget {
  const ProblemsPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            HomeAppBar(),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ProblemPostComponent(
                          
                          tags: [
                            "#LostPokemon",
                            "#Charizard"
                          ],
                          views: "10k",
                          imageUrl: "assets/problems/problem1.jpeg",
                          username: 'Ash Ketchum',
                          timeAgo: '2 hours ago',
                          location: "Mumbai, Maharashtra, India",
                          content: 'I lost my Charizard',
                          likes: 10,
                          dislikes: 2,
                          comments: 5);
                    }))
          ],
        ),
      ),
    );
  }
}
