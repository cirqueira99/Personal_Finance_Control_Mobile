import 'package:flutter/material.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        toolbarHeight: 15,
      ),
      body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight*0.85,
              width: screenWidth*0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('lib/assets/images/logo.png', width: 150,)
                  ),
                  const LoginForm(),
                  const TextDescription(),
              ],
        ),
            ),
          ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    String user;
    String pass;

    return SizedBox(
      height: 200,
      width: screenWidth*0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 300,
            margin: const EdgeInsets.all(5),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'User',
                  icon: Icon(Icons.person, size: 20,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.black26
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.redAccent),
                  )
              ),
              validator: (String? value){
                if(value == null){
                  return 'Preencha o campo user!';
                }
                return null;
              },
              onSaved: (String? value) => setState(() => user = value ?? ''),
            ),
          ),
          Container(
            height: 45,
            width: 300,
            margin: const EdgeInsets.all(5),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.pending, size: 20,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.black26
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.redAccent)
                  )
              ),
              validator: (String? value){
                if(value == null){
                  return 'Preencha o campo password!';
                }
                return null;
              },
              onSaved: (String? value) => setState(() => pass = value ?? ''),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushNamed('home');
            },
            child: const Text('Login', style: TextStyle(fontSize: 16),),
          ),
        ],
      ),
    );
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        width: 300,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(5)
        ),
        child: const Text('''
            O trabalho tem como objetivo a elaboração de um projeto que consiste na criação de um aplicativo de Controle Financeiro, possibilitando ao usuário diversas funcionalidades (lançamentos de receita, lançamentos de gastos, realização de pagamentos, realização de transferência, etc) para o cumprimento de tal controle.''',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
