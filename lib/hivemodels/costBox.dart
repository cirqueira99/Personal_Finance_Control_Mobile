import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CostBoxModel extends HiveObject {
  @HiveField(0)
  late String dateRelease;
  @HiveField(1)
  late String description;
  @HiveField(3)
  late String category;
  @HiveField(4)
  late String account;
  @HiveField(5)
  late String observation;
  @HiveField(6)
  late int valueCost;
  @HiveField(7)
  late int parcels;
  @HiveField(8)
  late String datePayment;
  @HiveField(1)
  late String typePayment;
  @HiveField(1)
  late bool status;
}