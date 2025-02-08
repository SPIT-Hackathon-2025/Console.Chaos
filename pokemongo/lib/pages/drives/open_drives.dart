import 'package:flutter/material.dart';
import 'package:pokemongo/pages/drives/open_drives_appbar.dart';
import 'package:pokemongo/themes.dart';
import 'package:pokemongo/widgets/open_drives_post.dart';

class OpenDrives extends StatelessWidget {
  const OpenDrives({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            OpenDriveAppBar(),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with the actual number of items
                itemBuilder: (context, index) {
                  return CommunityDriveCard(
                    imageUrl: 'assets/problems/problem${index + 1}.jpeg',
                    location: 'Location $index',
                    title: 'Community Drive $index',
                    time: 'Time $index',
                    onRsvp: () {
                      print('RSVP clicked for drive $index!');
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
