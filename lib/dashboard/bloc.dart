import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState().init());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<DashboardState> init() async {
    return state.clone();
  }
}
