import 'package:flutter/material.dart';
import 'package:pokemongo/constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/constants.dart';

class LostFoundItem extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String location;
  final String timeFound;
  final String description;
  final VoidCallback onClaim;
  final bool isOwner;
  final int commentsCount;
  final int claimCount;
  final RxBool isClaimed; // Reactive variable

  LostFoundItem({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.location,
    required this.timeFound,
    required this.description,
    required this.onClaim,
    required this.isOwner,
    this.commentsCount = 0,
    this.claimCount = 0,
    required this.isClaimed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              "Found at: $location",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey),
            ),
            Text("Time: $timeFound",
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            if (isOwner) ...[
              const Divider(),
              Text(
                "Comments: $commentsCount",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                "Claims: $claimCount",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 6),
            ] else
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isClaimed.value
                          ? null
                          : () {
                              onClaim();
                              isClaimed.value = true;
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isClaimed.value ? Colors.grey : Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        isClaimed.value ? "Claimed" : "Claim Item",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
