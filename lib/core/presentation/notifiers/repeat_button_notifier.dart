import 'package:flow/core/domain/models/repeat_state.dart';
import 'package:flutter/cupertino.dart';

class RepeatButtonNotifier extends ValueNotifier<RepeatState> {
  RepeatButtonNotifier() : super(_initialState);

  //  initial value
  static const _initialState = RepeatState.off;

  //  move to the next state
  void nextState() {
    final next = (value.index + 1) % RepeatState.values.length;
    value = RepeatState.values[next];
  }
}