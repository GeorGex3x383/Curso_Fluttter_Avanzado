import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:io';

import 'package:band_names_app/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Gorillaz', votes: 5),
    Band(id: '2', name: 'Ramstein', votes: 2),
    Band(id: '3', name: 'Big Time Rush', votes: 8),
    Band(id: '4', name: 'Matisse', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        backgroundColor: Colors.black,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {

    final random = Random();

    return Dismissible(
      key: Key("${band.id}"),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        print('id: ${band.id}');
      },
      background: Container(
        padding: const EdgeInsets.only(right: 10.0),
        color: Colors.black,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Text('Eliminar Banda', style: TextStyle(color: Colors.white)),
        ),
        ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0,3), style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.black
        ),
        title: Text('${band.name}'),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: (){},
      ),
    );
  }

  addNewBand(){

    final textController = TextEditingController();

    if(Platform.isAndroid){
        return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Band Name:'),
            content: TextField(
              controller: textController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(        
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: Colors.black),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),  
              ),
            ),
            actions: [
              MaterialButton(
                child: const Text('Añadir'),
                elevation: 3,
                onPressed: () => addBandToList(textController.text),
              ),
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_){
        return CupertinoAlertDialog(
          title: const Text('New Band Name:'),
          content: CupertinoTextField(
            controller: textController
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Añadir'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      } 
    );

  }

  void addBandToList(String name){

    if(name.length > 1){
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0 ));
      setState(() {});
    }
    

    Navigator.pop(context);

  }

}
