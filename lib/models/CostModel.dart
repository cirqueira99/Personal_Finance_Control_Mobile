
class CostModel {
  String dateRelease;
  String description;
  String category;
  String account;
  String observation;
  double valueCost;
  int parcels;
  String datePayment;
  String typePayment;
  bool status;

  CostModel({
    required this.dateRelease,
    required this.description,
    required this.category,
    required this.account,
    required this.observation,
    required this.valueCost,
    required this.parcels,
    required this.datePayment,
    required this.typePayment,
    required this.status
  });

  Object getValuesToJson(){
    Object cost = {
      'dateRelease': dateRelease,
      'description': description,
      'category': category,
      'account': account,
      'observation': observation,
      'valueCost': valueCost,
      'parcels': parcels,
      'datePayment': dateRelease,
      'typePayment': typePayment,
      'status': status
    };

    return cost;
  }
}
