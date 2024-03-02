class Category {
  final int categoryId;
  final String name;
  final String icon;

  Category({
    required this.categoryId,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}
