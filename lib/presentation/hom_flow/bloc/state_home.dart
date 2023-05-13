
import 'package:equatable/equatable.dart';
class HomeState extends Equatable {
  final String valueChanged;
  final bool valueCleared;
  final int shapeChanged;

  const HomeState({this.valueChanged,this.valueCleared=false,this.shapeChanged=0});

  HomeState copyWith({
    String valueChanged,
    bool valueCleared,
    int shapeChanged
  }) {
    return HomeState(valueChanged: valueChanged ?? this.valueChanged,valueCleared: valueCleared??false,shapeChanged:shapeChanged??this.shapeChanged);
  }

  @override
  // TODO: implement props
  List<Object> get props =>[valueChanged,valueCleared,shapeChanged];
}
