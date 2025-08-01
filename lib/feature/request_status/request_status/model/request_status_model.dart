class RequestStatusModel {
  final String name;
  final String description;
  final double currentAmount;
  final double totalAmount;
  final double percentage;

  RequestStatusModel({
    required this.name,
    required this.description,
    required this.currentAmount,
    required this.totalAmount,
    required this.percentage,
  });

  factory RequestStatusModel.fromJson(Map<String, dynamic> json) {
    return RequestStatusModel(
      name: json['name'],
      description: json['description'],
      currentAmount: (json['current_amount'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
      
    );
  }
}
