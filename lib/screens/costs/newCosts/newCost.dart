import 'package:controle_financeiro/models/CostModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:web_date_picker/web_date_picker.dart';


class NewCost extends StatelessWidget {
  const NewCost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Despesa'),
        toolbarHeight: 50,
        backgroundColor: Colors.red.shade900,
        leading: const BackButton(color: Colors.white),
      ),
      body: const Center(
          child: SingleChildScrollView(
              child: ContainerForm(),
          ),
      ),
    );
  }
}

class ContainerForm extends StatefulWidget {
  const ContainerForm({Key? key}) : super(key: key);

  @override
  State<ContainerForm> createState() => _ContainerFormState();
}

class _ContainerFormState extends State<ContainerForm> {
  final costBox = Hive.box('cost');
  final _formkey = GlobalKey<FormState>();
  final newCost = CostModel(
      dateRelease: '',
      description: '',
      category: '',
      account: '',
      observation: '',
      valueCost: 0,
      parcels: 0,
      datePayment: '',
      typePayment: '',
      status: false
  );
  bool repetCosts = false;
  int valueCost = 0;
  int parcelsCost = 0;
  DateTime selectedDateToday = DateTime.now();
  DateTime selectedDatePayed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      width: double.infinity,
      color: Colors.red.shade50,
      child: Form(
        key: _formkey,
        child: Container(
          height: screenHeight,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30)
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              topForm(screenWidth, screenHeight),
              bodyFormCost(screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectedDateToday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateToday,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDateToday) {
      setState(() {
        selectedDateToday = picked;
        newCost.dateRelease = selectedDateToday.toString();
      });
    }
  }

  Future<void> _selectedDatePayed(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDatePayed,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDatePayed) {
      setState(() {
        selectedDatePayed = picked;
        newCost.datePayment = selectedDatePayed.toString();
      });
    }
  }

  Widget topForm(screenW, screenH){
    return Container(
      height: 130,
      width: 360,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          costValueRelease(),
          costDateRelase(),
        ],
      ),
    );
  }

  Widget costValueRelease(){
    return SizedBox(
      height: 90,
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Valor da Despesa', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
          Container(
            height: 50,
            width: 290,
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  labelText: 'R# 0,00',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.redAccent)
                  )
              ),
              validator: (String? value){
                if(value == null){
                  const SnackBar(
                    content:  Text('Preencher Valor!', style: TextStyle(color: Colors.black38),),
                    backgroundColor: Colors.black54,
                    behavior: SnackBarBehavior.floating,
                  );
                }
                return null;
              },
              onChanged: (String? value) {
                setState(() {
                  newCost.valueCost = double.parse(value!);
                },);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget costDateRelase(){
    return SizedBox(
      height: 80,
      width: 180,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const Text('Data da Despesa',style: TextStyle(fontSize: 14),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    '${selectedDateToday.day}/${selectedDateToday.month}/${selectedDateToday.year}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide.none,
                      backgroundColor: Colors.red.shade50),
                      onPressed: () {
                        _selectedDateToday(context);
                      },
                      child: Icon(Icons.date_range, size: 30, color: Colors.red.shade800,)
                  ),
                ),
              ],
            ),
          ],
      ),
    );
  }

  Widget bodyFormCost(screenW, screenH){
    return Container(
      height: screenH * 0.72,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFDAD2D2),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
          bottom: Radius.circular(30),
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          costDescription(),
          costCategory(),
          costAccount(),
          costObservation(),
          costParcels(),
          costInfoPayment(),
          bottomCostSave()
        ],
      ),
    );
  }

  Widget costDescription(){
    return Container(
      height: 60,
      width: 350,
      margin: const EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Descrição',
          icon: Icon(Icons.pending, size: 20,),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent)
          )
        ),
        validator: (String? value){
          if(value == null){
            const SnackBar(
              content:  Text('Preencher o campo despeza!', style: TextStyle(color: Colors.black38),),
              backgroundColor: Colors.black45,
              behavior: SnackBarBehavior.floating,
            );
            return null;
          }
        },
        onChanged: (String? value) => setState(() => newCost.description = value ?? ''),
      ),
    );
  }

  Widget costCategory(){
    final List<String> categorys = <String>['Categoria', 'Moradia', 'Alimentação', 'Educação', 'Lazer', 'Transporte', 'Saúde', 'Roupas'];
    String categorySelected = categorys[0];

    return Container(
      height: 60,
      width: 350,
      margin: const EdgeInsets.all(5),
      child: DropdownButtonFormField<String>(
        value: categorySelected,
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(color: Colors.black54, fontSize: 14),
        decoration: const InputDecoration(
          icon: Icon(Icons.bookmark_border, size: 20),
        ),
        dropdownColor: Colors.red[50],
        items: categorys.map<DropdownMenuItem<String>>((String c) {
          return DropdownMenuItem<String>(
            value: c,
            child: Text(c, style: const TextStyle(fontSize: 16),),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            categorySelected = value ?? '';
            newCost.category = value ?? '';
            },
          );
        },
        validator: (String? value){
          if(value == null || value == 'Categoria'){
            const SnackBar(
              content:  Text('Selecione uma categoria!', style: TextStyle(color: Colors.black38),),
              backgroundColor: Colors.black45,
              behavior: SnackBarBehavior.floating,
            );
          }
          return null;
        }
      ),
    );
  }

  Widget costAccount(){
    final List<String> accounts = <String>['Conta', 'Banco do Brasil', 'Nubank', 'Itau'];
    String accountSelected = accounts[0];

    return Container(
      height: 60,
      width: 350,
      margin: const EdgeInsets.all(5),
      child: DropdownButtonFormField<String>(
        value: accountSelected,
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(color: Colors.black54, fontSize: 14),
        decoration: const InputDecoration(
          icon: Icon(Icons.account_balance_wallet, size: 20,),
        ),
        dropdownColor: Colors.red[50],
        items: accounts.map<DropdownMenuItem<String>>((String c) {
          return DropdownMenuItem<String>(
            value: c,
            child: Text(c, style: const TextStyle(fontSize: 16),),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            accountSelected = value ?? '';
            newCost.account = value ?? '';
          },);
        },
        validator: (String? value){
          if(value == null || value == 'Conta'){
            const SnackBar(
              content:  Text('Selecione uma conta!', style: TextStyle(color: Colors.black38),),
              backgroundColor: Colors.black45,
              behavior: SnackBarBehavior.floating,
            );
          }
          return null;
        }
      ),
    );
  }

  Widget costObservation(){
    return Container(
      height: 60,
      width: 350,
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Observação',
            icon: Icon(Icons.remove_red_eye, size: 20,),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.redAccent)
            )
        ),
        onChanged: (String? value) => setState(() => newCost.observation = value?? ''),
      ),
    );
  }

  Widget costParcels(){
    return SizedBox(
      height: 50,
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            child: Row(
              children: [
                const Icon(Icons.cached, color: Colors.black54,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Repete: ', style: TextStyle(fontSize: 16),),
                ),
                Switch(
                  value: repetCosts,
                  onChanged: (bool? value)=>{
                    setState((){ repetCosts = value!; }
                  ),
                }),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('Quantas vezes? ', style: TextStyle(fontSize: 16),),
                SizedBox(
                  height: 20,
                  width: 30,
                  child: TextFormField(
                    readOnly: repetCosts? false: true,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      fillColor: Colors.black12
                    ),
                    validator: (String? value){
                      if((repetCosts) && (value == null)){ return 'Preencha quantas vezes se repete!';}
                      return null;
                    },
                    onChanged: (String? value) => setState(() => newCost.parcels = int.parse(value!) ?? 0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget costInfoPayment(){
    return Container(
      height: 100,
      width: 390,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40,
            child: Row(
              children: <Widget>[
                const Icon(Icons.info_outline, size: 20,),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Informações de pagamento:',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            )
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                typePayment(),
                costDatPayment(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget typePayment(){
    final List<String> typePayment = <String>['Tipo Pagamento', 'Dinheiro', 'Cartão Crédito', 'Cartão Débito', 'Pix'];
    String typePaymentSelected = typePayment[0];

    return SizedBox(
      height: 50,
      width: 185,
      child: DropdownButtonFormField<String>(
        value: typePaymentSelected,
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(color: Colors.black54, fontSize: 14),
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.payments_outlined, size: 20),
        ),
        dropdownColor: Colors.red[50],
        items: typePayment.map<DropdownMenuItem<String>>((String c) {
          return DropdownMenuItem<String>(
            value: c,
            child: Text(c, style: const TextStyle(fontSize: 16),),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            typePaymentSelected = value ?? '';
            newCost.typePayment = value ?? '';
          },);
        },
      ),
    );
  }

  Widget costDatPayment(){
    return SizedBox(
      height: 40,
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              '${selectedDatePayed.day}/${selectedDatePayed.month}/${selectedDatePayed.year}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          SizedBox(

            width: 55,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    backgroundColor: Colors.red.shade50),
                onPressed: () {
                  _selectedDatePayed(context);
                },
                child: Icon(Icons.date_range, size: 25, color: Colors.red.shade800,)
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomCostSave(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade900,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)
            )
        ),
        onPressed: () {
          if(_formkey.currentState!.validate()){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Despeza Criada!', style: TextStyle(color: Colors.black38),),
                backgroundColor: Colors.green.shade300,
                behavior: SnackBarBehavior.floating,
              ),
            );
            setState(() async {
              await costBox.add( newCost.getValuesToJson() );
            },);

          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Não foi possível realizar o cadastro!', style: TextStyle(color: Colors.black38),),
                backgroundColor: Colors.green.shade300,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.save, size: 24,),
              Text('Salvar', style: TextStyle(fontSize: 12),)
            ]
        ),
      ),
    );
  }
}
