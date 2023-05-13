part of 'infinite_list_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetched extends PostEvent {
  final Map<String, dynamic> extraParams;

  DataFetched({this.extraParams});
}

class ResetEvent extends PostEvent {}

class ChangeListType extends PostEvent {
  final ListType listType;

  ChangeListType(this.listType);
}
