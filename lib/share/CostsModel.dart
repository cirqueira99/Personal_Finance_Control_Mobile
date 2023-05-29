
import '../models/CostModel.dart';

class CostsModel{

  Map<String, List<Map<dynamic, dynamic>>> listToDate(List<dynamic> _list){
    List<Map<dynamic, dynamic>> releasesCosts = [];
    Map<String, List<Map<dynamic, dynamic>>> newList= {};
    late String lastDate;

    if(_list.isEmpty){
      print('empty!!');
      return {};
    }
    _list.sort((a, b) => a['dateRelease'].compareTo(b['dateRelease']));

    lastDate = _list[0]['dateRelease'];

    for (Map<dynamic, dynamic> cost in _list){
      if(cost['dateRelease'] != lastDate){
        newList[lastDate] = releasesCosts;
        lastDate = cost['dateRelease'];
        releasesCosts = [];
      }
      releasesCosts.add(cost);
    }
    newList[lastDate] = releasesCosts;

    return newList;
  }

  Map<String, num> sumPendentAndPayed(List<dynamic> _list){
    Map<String, num> sum = {'sumPendent': 0, 'sumPayed': 0};

    if(_list.isEmpty){
      return sum;
    }
    for (Map<dynamic, dynamic> cost in _list){
      cost['status']? sum['sumPayed'] = (sum['sumPayed']! + cost['valueCost'])!: sum['sumPendent'] = (sum['sumPendent']! + cost['valueCost'])!;
    }

    return sum;
  }
}