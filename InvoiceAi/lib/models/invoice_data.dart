import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../utils/date_parser.dart';

part 'invoice_data.g.dart';

@HiveType(typeId: 0)
class InvoiceData extends HiveObject {
  @HiveField(0)
  final String imagePath;
  @HiveField(1)
  late String _id;
  @HiveField(2)
  final String companyName;
  @HiveField(3)
  final String invoiceNo;
  @HiveField(4)
  late final DateTime date;
  @HiveField(5)
  final double totalAmount;
  @HiveField(6, defaultValue: 0.0)
  final double taxAmount;
  @HiveField(7, defaultValue: "Others")
  final String category;

  String get id => _id;

  InvoiceData(
      {required this.imagePath,
      required this.companyName,
      required this.invoiceNo,
      required this.date,
      required this.totalAmount,
      required this.taxAmount,
      required this.category,
      final String? id}) {
    id != null ? _id = id : _id = const Uuid().v4();
  }

  InvoiceData.fromJson(final Map<String, dynamic> json)
      : imagePath = json["ImagePath"] ?? "",
        companyName = json["companyName"] ?? "",
        invoiceNo = json["invoiceNo"] ?? "",
        date = dateParser(json["date"] ?? DateTime.now().toString()),
        category = json["category"] ?? "",
        _id = const Uuid().v4(),
    totalAmount = _parseAmount(json["totalAmount"] ?? "0"),
    taxAmount = _parseAmount(json["taxAmount"] ?? "0");

  static double _parseAmount(String amount) {
    if (amount[amount.length - 3] == ".") {
      final List<String> charList = amount.split('');
      charList[charList.length - 3] = ",";
      amount = charList.join();
    }
    return double.tryParse(amount.replaceAll(".", "").replaceAll(",", ".")) ?? 0;
  }

  InvoiceData copyWith({
    final String? imagePath,
    final String? companyName,
    final String? invoiceNo,
    final DateTime? date,
    final double? totalAmount,
    final double? taxAmount,
    final String? category,
    final String? id,
  }) {
    return InvoiceData(
      imagePath: imagePath ?? this.imagePath,
      companyName: companyName ?? this.companyName,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      date: date ?? this.date,
      totalAmount: totalAmount ?? this.totalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      category: category ?? this.category,
      id: id ?? _id,
    );
  }

}
