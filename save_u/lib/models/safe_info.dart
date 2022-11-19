class SafeInfo {
  int? id;
  String? title;
  String? content;
  bool? scrab;
  String? link;
  int? subCategoryId;

  SafeInfo(
      {this.id,
      this.title,
      this.content,
      this.scrab,
      this.link,
      this.subCategoryId});

  factory SafeInfo.fromJson(Map<String, dynamic> json) => SafeInfo(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      scrab: json['scrab'],
      link: json['link'],
      subCategoryId: json['subCategoryId']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'scrab': scrab,
        'link': link,
        'subCategoryId': subCategoryId
      };
}
