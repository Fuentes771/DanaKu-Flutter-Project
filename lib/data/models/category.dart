enum CategoryType { expense, income }

class AppCategory {
  final String id;
  final String name;
  final CategoryType type;

  const AppCategory({
    required this.id,
    required this.name,
    required this.type,
  });

  AppCategory copyWith({String? id, String? name, CategoryType? type}) => AppCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory AppCategory.fromJson(Map<String, dynamic> json) => AppCategory(
        id: json['id'] as String,
        name: json['name'] as String,
        type: CategoryType.values.firstWhere((e) => e.name == json['type'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type.name,
      };
}
