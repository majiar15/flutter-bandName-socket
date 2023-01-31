import 'dart:io';

import 'package:brand_name/models/brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: "Martin Jimenez", votes: '12'),
    Band(id: '2', name: "Maria Jimenez", votes: '6'),
    Band(id: '3', name: "Karen Molano", votes: '1')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle(color: Colors.black87)),
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => bandTitle(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget bandTitle(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direccion $direction');
        //todo: llamar el borrado en el server
      },
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete end', style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes,
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    TextEditingController textController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('new Band Name:'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                  elevation: 5,
                  // ignore: avoid_print
                  onPressed: () => addBandToList(textController.text),
                  child: const Text('add'))
            ],
          );
        },
      );
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('new Band Name:'),
            content: CupertinoTextField(controller: textController),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text('Dismiss'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => addBandToList(textController.text),
                child: const Text('Add'),
              ),
            ],
          );
        });
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: '0'));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
