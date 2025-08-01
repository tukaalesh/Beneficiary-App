class FoodRequestModel {
  final String fullName;
  final int age;
  final String gender;
  final String? maritalStatus;
  final String phoneNumber;
  final int numberOfKids;
  final String kidsDescription;
  final String governorate;
  final String homeAddress;
  final int monthlyIncome;
  final String currentJob;
  final String? monthlyIncomeSource;
  final String description;
  final int expectedCost;
  final List<String> neededFoodHelp;

  FoodRequestModel({
    required this.fullName,
    required this.age,
    required this.gender,
    this.maritalStatus,
    required this.phoneNumber,
    required this.numberOfKids,
    required this.kidsDescription,
    required this.governorate,
    required this.homeAddress,
    required this.monthlyIncome,
    required this.currentJob,
    this.monthlyIncomeSource,
    required this.description,
    required this.expectedCost,
    required this.neededFoodHelp,
  });

  factory FoodRequestModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    String? parseNullableString(dynamic value) {
      if (value == null) return null;
      if (value is String && value.trim().isEmpty) return null;
      return value.toString();
    }

    List<String> parseStringList(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return [];
    }

    return FoodRequestModel(
      fullName: json['full_name']?.toString() ?? '',
      age: parseInt(json['age']),
      gender: json['gender']?.toString() ?? '',
      maritalStatus: parseNullableString(json['marital_status']),
      phoneNumber: json['phone_number']?.toString() ?? '',
      numberOfKids: parseInt(json['number_of_kids']),
      kidsDescription: json['kids_description']?.toString() ?? '',
      governorate: json['governorate']?.toString() ?? '',
      homeAddress: json['home_address']?.toString() ?? '',
      monthlyIncome: parseInt(json['monthly_income']),
      currentJob: json['current_job']?.toString() ?? '',
      monthlyIncomeSource: parseNullableString(json['monthly_income_source']),
      description: json['description']?.toString() ?? '',
      expectedCost: parseInt(json['expected_cost']),
      neededFoodHelp: parseStringList(json['needed_food_help']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'age': age,
      'gender': gender,
      'marital_status': maritalStatus,
      'phone_number': phoneNumber,
      'number_of_kids': numberOfKids,
      'kids_description': kidsDescription,
      'governorate': governorate,
      'home_address': homeAddress,
      'monthly_income': monthlyIncome,
      'current_job': currentJob,
      'monthly_income_source': monthlyIncomeSource,
      'description': description,
      'expected_cost': expectedCost,
      'needed_food_help': neededFoodHelp,
    };
  }
}
