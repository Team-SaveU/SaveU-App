import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_u/pages/main_page.dart';
import 'package:save_u/pages/no_user_page.dart';
import 'package:save_u/pages/qna_page.dart';
import 'package:save_u/pages/safe_map_page.dart';
import 'package:save_u/sevices/auth_service.dart';
import 'package:save_u/pages/my_page.dart';
import 'package:save_u/sevices/comment_service.dart';
import 'package:save_u/sevices/question_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => QuestionService()),
        ChangeNotifierProvider(create: (context) => CommentService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 홈페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; //변수명 앞에 언더바 붙이면 해당 클래스 내에서만 사용 가능하다는것

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          MainPage(),
          user == null ? NoUserPage() : QnAPage(),
          SafeMapPage(),
          MyPage(),
        ], //children
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, //첫번째부터 0, 3까지
        onTap: (value) {
          setState(() {
            _selectedIndex = value; //클릭하면 value값이 할당되며 rebuild됨
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Q&A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_sharp),
            label: '세이프맵',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
