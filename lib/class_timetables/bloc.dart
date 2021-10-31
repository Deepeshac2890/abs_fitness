import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class ClassTimetablesBloc extends Bloc<ClassTimetablesEvent, ClassTimetablesState> {
  ClassTimetablesBloc() : super(ClassTimetablesState().init());

  @override
  Stream<ClassTimetablesState> mapEventToState(ClassTimetablesEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<ClassTimetablesState> init() async {
    return state.clone();
  }
}
