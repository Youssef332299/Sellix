class CompanyModel {
  final String id;
  final String name;
  final List<String> phones;
  final List<String> branches;
  final String ordersInfo;
  final String cashierPassword;

  CompanyModel({
    required this.id,
    required this.name,
    required this.phones,
    required this.branches,
    required this.ordersInfo,
    required this.cashierPassword,
  });

  factory CompanyModel.fromFirestore(
      Map<String, dynamic> data, String id) {
    return CompanyModel(
      id: id,
      name: data["name"] ?? "",
      phones: List<String>.from(data["phones"] ?? []),
      branches: List<String>.from(data["branches"] ?? []),
      ordersInfo: data["ordersInfo"] ?? "",
      cashierPassword: data["cashierPassword"] ?? "",
    );
  }
}
