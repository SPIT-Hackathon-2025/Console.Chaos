import 'package:flutter/material.dart';
import 'package:pokemongo/pages/lost_and_found/lost_And_found_appbar.dart';
import 'package:pokemongo/themes.dart';
import 'package:pokemongo/widgets/lost_and_found_post.dart';

class LostAndFound extends StatelessWidget {
  const LostAndFound({super.key});

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
            LostFoundItem(
              imageUrl: "assets/problems/problem1.jpeg",
              description: 'found a Charizard at the park',
              location: 'Mumbai, Maharashtra, India',
              timeFound: '2 hours ago',
              onClaim: () {
                print('Claimed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
