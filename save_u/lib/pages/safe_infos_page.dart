import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/safe_info.dart';
import '../models/sub_category.dart';
import '../sevices/safe_info_service.dart';
import 'safe_info_detail_page.dart';

class SafeInfosPage extends StatefulWidget {
  final SubCategory subCategory;
  const SafeInfosPage({Key? key, required this.subCategory}) : super(key: key);

  @override
  State<SafeInfosPage> createState() => _SafeInfosPageState();
}

class _SafeInfosPageState extends State<SafeInfosPage> {
  late List<SafeInfo> _safeInfoList = <SafeInfo>[];
  final _safeInfoService = SafeInfoService();

  getSafeInfosBySubCategoryId() async {
    var safeInfos = await _safeInfoService
        .readSafeInfosBySubCategoryId(widget.subCategory.id ?? 0);
    _safeInfoList = <SafeInfo>[];
    safeInfos.forEach((safeInfo) {
      setState(() {
        var safeInfoModel = SafeInfo();
        safeInfoModel.id = safeInfo['id'];
        safeInfoModel.title = safeInfo['title'];
        safeInfoModel.content = safeInfo['content'];
        safeInfoModel.scrap = safeInfo['scrap'];
        safeInfoModel.link = safeInfo['link'];
        safeInfoModel.subCategoryId = safeInfo['subCategoryId'];
        _safeInfoList.add(safeInfoModel);
      });
    });
  }

  @override
  void initState() {
    getSafeInfosBySubCategoryId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.subCategory.name ?? "안전 정보"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _safeInfoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SafeInfoDetailPage(
                                safeInfo: _safeInfoList[index],
                              ))).then((value) {
                    getSafeInfosBySubCategoryId();
                    setState(() {});
                  });
                },
                title: Text(_safeInfoList[index].title ?? ''),
                trailing: IconButton(
                  icon: _safeInfoList[index].scrap == 0
                      ? Icon(CupertinoIcons.bookmark)
                      : Icon(
                          CupertinoIcons.bookmark_fill,
                          color: Colors.yellow,
                        ),
                  onPressed: () async {
                    if (_safeInfoList[index].scrap == 0) {
                      //스크랩 X인 경우
                      setState(() {
                        _safeInfoList[index].scrap = 1;
                      });
                    } else if (_safeInfoList[index].scrap == 1) {
                      //스크랩 한 경우
                      setState(() {
                        _safeInfoList[index].scrap = 0;
                      });
                    }
                    await _safeInfoService.updateSafeInfoScrap(
                        _safeInfoList[index].id ?? 0,
                        _safeInfoList[index].scrap ?? 0);
                  },
                ),
              ),
            );
          }),
    );
  }
}
