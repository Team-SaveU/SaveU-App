import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_u/pages/qna_details_page.dart';
import 'package:save_u/sevices/comment_service.dart';

import '../sevices/auth_service.dart';
import '../sevices/question_service.dart';

class MyQuestionPage extends StatefulWidget {
  const MyQuestionPage({super.key});

  @override
  State<MyQuestionPage> createState() => _MyQuestionPageState();
}

class _MyQuestionPageState extends State<MyQuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<QuestionService, CommentService>(
      builder: (context, questionService, commentService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;

        return Scaffold(
          appBar: null,
          body: user.email == null
              ? Text("로그인 후 이용 가능합니다.")
              : Column(
                  children: [
                    /// 질문 리스트
                    Expanded(
                      child: FutureBuilder<QuerySnapshot>(
                          future: questionService.read(user.uid),
                          builder: (context, snapshot) {
                            final documents =
                                snapshot.data?.docs ?? []; // 문서들 가져오기
                            if (documents.isEmpty) {
                              return Center(child: Text("작성한 질문이 없습니다."));
                            }
                            return ListView.builder(
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                final doc = documents[index];
                                String title = doc.get('title');
                                String content = doc.get('content');
                                return Card(
                                  child: FutureBuilder<QuerySnapshot>(
                                      future: commentService.read(doc.id),
                                      builder: (context, snapshot2) {
                                        final docs_comment =
                                            snapshot2.data?.docs ?? [];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      QnADetailsPage(
                                                    questionId: doc.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            title: Text(
                                              "Q. $title",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Text(
                                                content,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            trailing: RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(
                                                        CupertinoIcons
                                                            .chat_bubble_text_fill,
                                                        size: 16),
                                                  ),
                                                  TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                    ),
                                                    text:
                                                        " ${docs_comment.length}",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              },
                            );
                          }),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
