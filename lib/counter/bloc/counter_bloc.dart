import 'dart:async';

import 'package:app/counter/event/counter_event.dart';


class CounterBloc
{
  int incrementCount = 0;

  //sink value from 
  final _counterControllerEvent = StreamController<CounterEvent>();
  //
  Sink<CounterEvent> get counterEventSink => _counterControllerEvent.sink;

  //stream set state
  final _counterControllerState = StreamController<int>();
  //get input use sink
  StreamSink<int> get counterInputSink => _counterControllerState.sink;
  //send out put to view use stram
  Stream<int> get counterStream => _counterControllerState.stream;

  CounterBloc()
  {
    //get input from view use listen
    _counterControllerEvent.stream.listen(mapEventToState);
  }

  void mapEventToState(CounterEvent event)
  {
    if(event is Increment)
    {
      incrementCount++;
    }
    else
    incrementCount--;

    //add input to sink control
    counterInputSink.add(incrementCount);
  }

  void dispose()
  {
    _counterControllerEvent.close();
    _counterControllerState.close();
  }
}