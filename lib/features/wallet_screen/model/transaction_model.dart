class TransactionModel {
  TransactionModel({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? walletId;
  final String? type;
  final String? amount;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionModel copyWith({
    int? id,
    int? walletId,
    String? type,
    String? amount,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json){
    return TransactionModel(
      id: json["id"],
      walletId: json["wallet_id"],
      type: json["type"],
      amount: json["amount"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
