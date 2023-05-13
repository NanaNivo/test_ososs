import 'package:test_ososs/presentation/hom_flow/bloc/event_home.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/state_home.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    /// App Events
    on<ChangeValue>(_onChangeValue);
    on<ClearValue>(_onClearValue);
    on<ChangeShape>(_onChangeShape);
  }
}

extension HomeBlocMappers on HomeBloc {
  void _onChangeValue(ChangeValue event, Emitter<HomeState> emit) async {

    emit(state.copyWith(valueChanged: event.value));
  }
  void _onClearValue(ClearValue event, Emitter<HomeState> emit) async {

    emit(state.copyWith(valueCleared: true,valueChanged: ""));
  }
  void _onChangeShape(ChangeShape event,Emitter<HomeState> emit) async {
    emit(state.copyWith(shapeChanged: event.shape));
  }

}
extension HomeBlocEvent on HomeBloc
{
  void setValue(String value)
  {
    add(ChangeValue(value: value));
  }
  void setClear()
  {
    add(ClearValue());
  }
  void shangeShape(int shape)
  {
    add(ChangeShape(shape: shape));
  }
}
