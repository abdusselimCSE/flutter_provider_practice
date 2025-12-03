import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    int count = state + 1;
    emit(count);
  }

  void decrement() {
    int count = state - 1;
    emit(count);
  }

  @override
  void onChange(Change<int> change) {
    // TODO: implement onChange
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
  }
}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) {
      int count = state + 1;
      emit(count);
    });

    on<DecrementEvent>((event, emit) {
      int count = state - 1;
      emit(count);
    });
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
  }
}

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}
