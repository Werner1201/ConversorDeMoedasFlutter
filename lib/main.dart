import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=cde39249";

void main() async{
  runApp(MaterialApp(
    home: Home(),
  ));
}

//Funcao que pega os dados Da API de maneira Assincrona
//Decodifica o JSON no corpo da resposta em um Map.
Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      //FutureBuilder vai mostrar algo na tela enquanto o Map do getData() eh resolvido
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          //Aqui caso o estado da conexao seja ou esperando ou nada ele vai mostrar que esta carregando
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                      "Carregando Dados...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
                //Caso normalmente tenha erro, vai mostrar erro
              default:
                if(snapshot.hasError){
                  return Center(
                    child: Text(
                      "Erro ao Carregar Dados :(",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }else{
                  //Se nao tiver erro vai mostrar os dados
                  return Container(color: Colors.green,);
                }
            }
        },
      ),
    );
  }
}



