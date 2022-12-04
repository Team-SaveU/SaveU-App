import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_u/sevices/question_service.dart';

import '../sevices/auth_service.dart';

class QnADetailsPage extends StatefulWidget {
  final String questionId;
  const QnADetailsPage({Key? key, required this.questionId}) : super(key: key);

  @override
  State<QnADetailsPage> createState() => _QnADetailsPageState();
}

class _QnADetailsPageState extends State<QnADetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionService>(
      builder: (context, questionService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;
        return Scaffold(
          appBar: null,
          body: FutureBuilder<DocumentSnapshot>(
            future: questionService.readOne(widget.questionId),
            builder: (context, snapshot) {
              final doc = snapshot.data!;
              if (doc.exists == false) {
                return Center(
                  child: Text("질문 정보를 가져오는 데 실패했습니다. \n나중에 다시 시도해주세요."),
                );
              } else {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(doc.data().toString().contains('title')
                            ? doc.get('title')
                            : '제목 정보가 없습니다.'),
                      ],
                    ),
                    RichText(
                      text: doc.data().toString().contains('content')
                          ? doc.get('content')
                          : '내용 정보가 없습니다.',
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}
