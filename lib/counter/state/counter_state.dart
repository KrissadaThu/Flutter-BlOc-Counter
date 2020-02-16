import 'package:app/counter/bloc/counter_bloc.dart';
import 'package:app/counter/event/counter_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  final counter = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: StreamBuilder(
        stream: counter.counterStream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Text("${snapshot.data}"),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ),
    bottomNavigationBar: Row
    (
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton
        (
          child: Icon(Icons.add),
          onPressed: () => counter.counterEventSink.add(Increment()),
        ),
        FloatingActionButton
        (
          child: Icon(Icons.remove),
          onPressed: () => counter.counterEventSink.add(Decrement()),
        )
      ],
    ),
    );
  }
}
