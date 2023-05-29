import 'package:controle_financeiro/models/CostModel.dart';
import 'package:controle_financeiro/share/CostsModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CostsPage extends StatefulWidget {

  const CostsPage({Key? key}) : super(key: key);

  @override
  State<CostsPage> createState() => _CostsPageState();
}

class _CostsPageState extends State<CostsPage> {
  final _costBox = Hive.box('cost');
  CostsModel costsModel = CostsModel();
  List _listCosts = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    _listCosts = _costBox.values.toList();

    // Map<dynamic, dynamic> custoT = _costBox.getAt(3);
    // custoT['status'] = true;
    // _costBox.putAt(3, custoT);

    Map<String, List<Map<dynamic, dynamic>>> listForDate = costsModel.listToDate(_listCosts);
    Map<String, num> sum = costsModel.sumPendentAndPayed(_listCosts);

    return Container(
      color: Colors.red.shade50,
      height: screenHeight * 0.9,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 170,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0XFF870505),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
            ),
            child:
            Column(
              children: <Widget>[
                const MonthTop(),
                SumCostsMonth(sum)
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.62,
            child: ListCosts(listForDate),
          )
        ],
      ),
    );
  }
}

class MonthTop extends StatefulWidget {
  const MonthTop({Key? key}) : super(key: key);

  @override
  State<MonthTop> createState() => _MonthTopState();
}

class _MonthTopState extends State<MonthTop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
          Text(
            'Julho',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
          Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}


class SumCostsMonth extends StatefulWidget {
  Map<String, num> sum;
  SumCostsMonth(this.sum, {Key? key}) : super(key: key);

  @override
  State<SumCostsMonth> createState() => _SumCostsMonthState();
}

class _SumCostsMonthState extends State<SumCostsMonth> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: 120,
      width: screenWidth,
      padding: const EdgeInsets.all(10),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.error_outline, size: 25, color: Colors.red.shade300,),
                Text('Total Pendente', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.grey.shade300)),
                Text(widget.sum['sumPendent'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey.shade300)),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            width: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check, size: 25, color: Colors.green.shade700,),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('Total Pago', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.grey.shade300)),
                      Text(widget.sum['sumPayed'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey.shade300)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ListCosts extends StatefulWidget {
  Map<String, List<Map<dynamic, dynamic>>> listCosts;
  ListCosts(this.listCosts, {Key? key}) : super(key: key);

  @override
  State<ListCosts> createState() => _ListCostsState();
}

class _ListCostsState extends State<ListCosts> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<String> listDates =  [];
    widget.listCosts.keys.forEach((key) { listDates.add(key); });

    return Container(
      width: screenWidth * 0.95,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))
      ),
      child:
      listDates.isEmpty?
      const CardEmpty():
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: listDates.length,
        itemBuilder: (_, index) {
          final List<Map<dynamic, dynamic>> currentDateItem = widget.listCosts[listDates[index]]!;
          return Column(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(listDates[index], style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              ),
              // renderCardsList(widget.listCostGroups[index]),
              ListView.builder(
                shrinkWrap: true,
                itemCount: currentDateItem.length,
                itemBuilder: (_, index){
                  final Map<dynamic, dynamic> currentCostItem = currentDateItem[index];
                  return CardCost(currentCostItem);
                },
              ),
            ],
          );
          // return
        },
      )
    );
  }

}

class CardEmpty extends StatelessWidget {
  const CardEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.error_outline, size: 26,),
          Text('Não há lançamentos!', style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}


class CardCost extends StatefulWidget {
  Map<dynamic, dynamic> costItem;
  CardCost(this.costItem, {Key? key}) : super(key: key);

  @override
  State<CardCost> createState() => _CardCostState();
}

class _CardCostState extends State<CardCost> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white60,
          border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey.shade300),
              bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
              left: BorderSide(width: 1.0, color: Colors.grey.shade300),
              right: BorderSide(width: 1.0, color: Colors.grey.shade300),
          ),
        borderRadius: BorderRadius.circular(10)
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
          SizedBox(
            height: 50,
            width: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.costItem['description'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                Row(
                  children: <Widget>[
                    Text(widget.costItem['category'], style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),),
                    const Text(' | ', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),),
                    Text(widget.costItem['account'], style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle, size: 20, color: widget.costItem['status']? Colors.green: Colors.red,
                ),
                Text(widget.costItem['valueCost'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
