import 'package:comment_tree/comment_tree.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  var comments = <int, List<Comment>>{}.obs;
  var commentsVisibility = <int, bool>{}.obs;

  void loadComments(int postId) {
    comments[postId] = [
      Comment(
          userName: 'Alice',
          content: 'This is a comment on post $postId.',
          avatar: ''),
    ];
  }

  void addComment(int postId, String content) {
    comments.putIfAbsent(postId, () => []);
    comments[postId]!
        .add(Comment(userName: 'Jainam Barbhaya', content: content, avatar: ''));
    update();
  }

  void addReply(int postId, Comment parentComment, String text) {
    int index = comments[postId]?.indexOf(parentComment) ?? -1;
    if (index != -1) {
      comments[postId]?.insert(
          index + 1, Comment(userName: 'Jainam Barbhaya', content: text, avatar: ''));
      update();
    }
  }

  void toggleCommentsVisibility(int postId) {
    commentsVisibility[postId] = !(commentsVisibility[postId] ?? false);
    update();
  }

  bool isCommentsVisible(int postId) {
    return commentsVisibility[postId] ?? false;
  }
}
