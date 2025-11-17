enum TransactionType { income, expense }

class AppTransaction {
  final String id;
  final int amount; // store in smallest unit (e.g., rupiah, not cents)
  final TransactionType type;
  final String categoryId;
  final DateTime date;
  final String? note;

  const AppTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.date,
    this.note,
  });

  AppTransaction copyWith({
    String? id,
    int? amount,
    TransactionType? type,
    String? categoryId,
    DateTime? date,
    String? note,
  }) => AppTransaction(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        categoryId: categoryId ?? this.categoryId,
        date: date ?? this.date,
        note: note ?? this.note,
      );

  factory AppTransaction.fromJson(Map<String, dynamic> json) => AppTransaction(
        id: json['id'] as String,
        amount: json['amount'] as int,
        type: TransactionType.values.firstWhere((e) => e.name == json['type'] as String),
        categoryId: json['categoryId'] as String,
        date: DateTime.parse(json['date'] as String),
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'type': type.name,
        'categoryId': categoryId,
        'date': date.toIso8601String(),
        'note': note,
      };
}
