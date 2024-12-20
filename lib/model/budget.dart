import 'package:json_annotation/json_annotation.dart';

part 'budget.g.dart';

@JsonSerializable()
class Budget {
  final String id;
  final String category;
  final double totalAmount;
  final Map<String, double> contributions;

  Budget({
    required this.id,
    required this.category,
    required this.totalAmount,
    required this.contributions,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  Budget copyWith({
    String? id,
    String? category,
    double? totalAmount,
    Map<String, double>? contributions,
  }) {
    return Budget(
      id: id ?? this.id,
      category: category ?? this.category,
      totalAmount: totalAmount ?? this.totalAmount,
      contributions: contributions ?? this.contributions,
    );
  }
}
