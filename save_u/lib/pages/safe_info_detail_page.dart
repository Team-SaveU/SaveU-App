import 'package:flutter/material.dart';

import '../models/safe_info.dart';

class SafeInfoDetailPage extends StatefulWidget {
  final SafeInfo safeInfo;
  const SafeInfoDetailPage({Key? key, required this.safeInfo})
      : super(key: key);

  @override
  State<SafeInfoDetailPage> createState() => _SafeInfoDetailPageState();
}

class _SafeInfoDetailPageState extends State<SafeInfoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("안전 정보 상세 보기"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(widget.safeInfo.title ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Container(
                  width: 350,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                            child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 100,
                          strutStyle: StrutStyle(fontSize: 16.0),
                          text: TextSpan(
                              text: widget.safeInfo.content ??
                                  '안전 정보를 불러오는 데 실패했습니다.',
                              style: TextStyle(
                                  color: Colors.black,
                                  height: 1.4,
                                  fontSize: 16.0,
                                  fontFamily: 'NanumSquareRegular')),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
/*
Flexible(
                          child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 50,
                        strutStyle: StrutStyle(fontSize: 16.0),
                        text: TextSpan(
                            text: widget.safeInfo.content ??
                                '안전 정보를 불러오는 데 실패했습니다.',
                            style: TextStyle(
                                color: Colors.black,
                                height: 1.4,
                                fontSize: 16.0,
                                fontFamily: 'NanumSquareRegular')),
                      )),
                       */