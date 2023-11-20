import 'dart:async';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as english_words;

class StreamControllerExample extends StatefulWidget{
  const StreamControllerExample({super.key});

  @override
  _StreamControllerExampleState createState()=>
  _StreamControllerExampleState();
}
//the data class in our stream, contains just a message string and a timestamp

class _Data {
  final String message;
  final DateTime timestamp;

  _Data({required this.message,required this.timestamp});
}

class _StreamControllerExampleState extends State<StreamControllerExample> {
 //the app puts value to _inputStreamController.sink, and renders widget from 
  //_outputStreamController.stream.
  final _inputStreamController = StreamController<_Data();
  final _outputStreamController = StreamController<Widget>();

  @override
  void initState(){
    super.initState();

  void _onData(_Data data){
    final widgetToRender= ListTile( 
      title:Text(data.message),
      subtitle:Text(data.timestamp.toString()),
    );
  _outputStreamController.sink.add(widgetToRender);
  }

  _inputStreamController.stream.listen(_onData) ;
}

@override
Widget build(BuildContext context){
  return ListView( 
   children:<Widget>[
    const Text( 
      "StreamController is like a pipe with `sink` as input ans `stream`"
      "as output. \n\n "
      "To put a new value to the stream,use `StreamController.sink.add(newValue)`;"
               ),
     Card ( 
    elevation:4.0,
    child :StreamBuilder<Widget>( 
      stream:_outputStreamController.stream,
      builder:(BuildContext context, AsyncSnapshot<Widget> snapshot){
        if(!snapshot.hasData){
          return const ListTile( 
           leading:CircularProgressIndicator(),
           title:Text("no data"),
          );
        }
      final Widget widgetToRender = snapshot.data!;
      return widgetToRender;
      },
    ),
  ),
  ElevatedButton.icon( 
    icon:const Icon(Icons.send),
    label:const Text('Send random word to input stream'),
    onPressed: ()=> this._inputStreamController.sink.add(
      _Data(
        message: english_words.WordPair.random().asPascalCase,
        timestamp: DateTime.now(),
    ),
    ),
  )
   ],
  );
}

@override
void dispose(){
  _inputStreamController.close();
  _outputStreamController.close();
  super.dispose();
  }
}

