import 'package:comment_tree/comment_tree.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/controller/post_controller.dart';

class CommentTreeComponent extends StatelessWidget {
  final int postId;
  final TextEditingController commentController = TextEditingController();
  CommentTreeComponent({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final CommentController controller = Get.put(CommentController());
    return Obx(
      () => Column(
        children: [
          if (controller.comments[postId]?.isNotEmpty ?? false)
            CommentTreeWidget<Comment, Comment>(
              controller.comments[postId]!.first,
              controller.comments[postId]!.sublist(1),
              treeThemeData:
                  TreeThemeData(lineColor: Colors.redAccent, lineWidth: 3),
              avatarRoot: (context, data) => PreferredSize(
                preferredSize: Size(40, 40),
                child: _buildAvatar(data),
              ),
              avatarChild: (context, data) => PreferredSize(
                preferredSize: Size(40, 40),
                child: _buildAvatar(data),
              ),
              contentRoot: (context, data) =>
                  _buildCommentItem(data, context, controller),
              contentChild: (context, data) =>
                  _buildCommentItem(data, context, controller),
            ),
          _buildCommentInput(controller),
        ],
      ),
    );
  }

  Widget _buildAvatar(Comment data) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: Text(data.userName?[0] ?? ''),
    );
  }

  Widget _buildCommentItem(
      Comment data, BuildContext context, CommentController controller) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.userName ?? '',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(data.content ?? ''),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => _showReplyDialog(context, data, controller),
              child: Text('Reply', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput(CommentController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (commentController.text.isNotEmpty) {
                controller.addComment(postId, commentController.text);
                commentController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Post'),
          ),
        ],
      ),
    );
  }

  void _showReplyDialog(BuildContext context, Comment parentComment,
      CommentController controller) {
    TextEditingController replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reply to ${parentComment.userName}'),
        content: TextField(
          controller: replyController,
          decoration: InputDecoration(
            hintText: 'Enter your reply',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              if (replyController.text.isNotEmpty) {
                controller.addReply(
                    postId, parentComment, replyController.text);
                Navigator.pop(context);
              }
            },
            child: Text('Reply'),
          ),
        ],
      ),
    );
  }
}
