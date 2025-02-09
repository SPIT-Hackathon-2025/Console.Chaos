import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/controller/community_service_controller.dart';
import 'package:pokemongo/pages/drives/open_drives_appbar.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/widgets/open_drives_post.dart';

class OpenDrives extends StatelessWidget {
  final CommunityServiceController controller =
      Get.put(CommunityServiceController());

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
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.events.isEmpty) {
                  return Center(child: Text("No drives available"));
                }
                return ListView.builder(
                  itemCount: controller.events.length,
                  itemBuilder: (context, index) {
                    var event = controller.events[index];
                    return CommunityDriveCard(
                      isOrganizer: false,
                      imageUrl: event.imageUrl,
                      location: event.location,
                      title: event.eventDetails,
                      time: event.eventDate,
                      onRsvp: () {
                        print('RSVP clicked for drive ${event.id}');
                      },
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
