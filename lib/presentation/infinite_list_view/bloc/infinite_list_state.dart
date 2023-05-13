part of 'infinite_list_bloc.dart';

enum ListStatus { initial, success, failure, errorWithData }

enum ListType { grid, list }

class InfiniteListState<T> extends Equatable {
  const InfiniteListState(
      {this.status = ListStatus.initial,
      this.data = const [],
      this.hasReachedMax = false,
      this.currentPage = 1,
      this.limit,
      this.listType = ListType.grid,
      this.isError = false,
      this.error});

  final ListStatus status;
  final List<T> data;
  final bool hasReachedMax;
  final int currentPage;
  final int limit;
  final String error;
  final bool isError;
  final ListType listType;

  InfiniteListState<T> copyWith(
      {ListStatus status,
      List<T> data,
      bool hasReachedMax,
      int currentPage,
      int limit,
      ListType listType,
      bool isError,
      Map<String, dynamic> currentParams,
      String error}) {
    return InfiniteListState<T>(
        status: status ?? this.status,
        data: data ?? this.data,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage,
        limit: limit ?? this.limit,
        isError: isError ?? this.isError,
        listType: listType ?? this.listType,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [
        status,
        data,
        hasReachedMax,
        currentPage,
        limit,
        error,
        isError,
        listType
      ];
}
