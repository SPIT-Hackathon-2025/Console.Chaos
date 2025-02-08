import 'package:flutter/material.dart';

class ProblemPostComponent extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String location;
  final String content;
  final String? imageUrl;
  final int likes;
  final int dislikes;
  final int comments;
  final String views;
  final List<String> tags;

  const ProblemPostComponent({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.location,
    this.imageUrl,
    required this.likes,
    required this.dislikes,
    required this.comments,
    required this.views,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/1.jpg'),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        timeAgo,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      const Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 5,
                      ),
                      SizedBox(width: 10),
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
          SizedBox(height: 20),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          if (imageUrl != null) ...[
            SizedBox(height: 20),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          SizedBox(height: 20),
          Wrap(
            spacing: 8.0,
            children: tags
                .map((tag) => Text(
                      tag,
                      style: TextStyle(color: Colors.blueAccent),
                    ))
                .toList(),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '$likes',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.thumb_down, color: Colors.grey, size: 15),
                    SizedBox(width: 10),
                    Text(
                      '$dislikes',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$views views',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.show_chart_sharp, color: Colors.green, size: 18),
              Spacer(),
              Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 15),
              SizedBox(width: 10),
              Text(
                '$comments',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
