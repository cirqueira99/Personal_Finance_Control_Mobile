import 'package:flutter/material.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        TopResume(),
        BottomAccountsList(),
      ],
    );
  }
}

class TopResume extends StatelessWidget {
  const TopResume({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(10),
      height: screenHeight*0.25,
      width: screenWidth,
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white60,
            ),
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('Saldo', style: TextStyle(fontWeight: FontWeight.normal),),
                    Text('0,00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent,
                  ),
                  height: 50,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text('Receita'),
                      Text('0,00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[300],
                  ),
                  height: 50,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text('Custos'),
                      Text('0,00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomAccountsList extends StatelessWidget {
  const BottomAccountsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.all(10),
      height: screenHeight*0.58,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('Contas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            height: screenHeight*0.50,
            width: screenWidth*0.9,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: const <Widget>[
                CardAccount(),
                CardAccount(),
                CardAccount(),
                CardAccount(),
                CardAccount()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardAccount extends StatelessWidget {
  const CardAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          const Icon(Icons.account_balance),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Banco do Brasil', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
              Text('0,00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green[900])),
            ],
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
