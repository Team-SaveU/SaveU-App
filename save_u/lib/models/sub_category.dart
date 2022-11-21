class SubCategory {
  int? id;
  String? name;
  int? categoryId;

  SubCategory({this.id, this.name, this.categoryId});

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['id'],
        name: json['name'],
        categoryId: json['categoryId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'categoryId': categoryId,
      };
}
