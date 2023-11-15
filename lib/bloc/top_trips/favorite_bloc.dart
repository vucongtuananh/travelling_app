import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBoolState {
  final bool one;
  final bool two;
  ChangeBoolState({this.one = false, this.two = true});
  ChangeBoolState copyWith({
    bool? one,
    bool? two,
  }) {
    return ChangeBoolState(one: one != null ? one : this.one, two: two != null ? two : this.two);
  }
}

class ChangeBoolCubit extends Cubit<ChangeBoolState> {
  ChangeBoolCubit(super.initialState);

  void changeOne() {
    emit(state.copyWith(
      one: !state.one,
    ));
  }
}
