import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class QuestionService extends ChangeNotifier {
  final questionCollection = FirebaseFirestore.instance.collection('question');

  Future<QuerySnapshot> read(String uid) async {
    // 내 questionList 가져오기
    return questionCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String title, String content, String uid) async {
    //uuid 생성
    var uuid = Uuid();
    uuid.v1();

    //현재 날짜 받아오기
    var now = new DateTime.now(); //반드시 다른 함수에서 해야함, Mypage같은 클래스에서는 사용 불가능
    String formatDate = DateFormat('yy-MM-dd HH:mm:ss').format(now);

    await questionCollection.doc(uuid.toString()).set({
      'uid': uid, // 유저 식별자
      'title': title, // 제목
      'content': content, // 내용
      'date': formatDate,
    });
  }

  void update(String docId, String content) async {
    // questionContent 업데이트
  }

  void delete(String docId) async {
    // question 삭제
  }
}
