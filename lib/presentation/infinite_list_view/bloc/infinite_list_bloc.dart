import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';



import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:test_ososs/core/error/http/forbidden_error.dart';
import 'package:test_ososs/core/param/base_param.dart';
import 'package:test_ososs/presentation/infinite_list_view/entity/pagination_params.dart';
import 'package:test_ososs/presentation/infinite_list_view/entity/usecase_wrapper.dart';

part 'infinite_list_event.dart';

part 'infinite_list_state.dart';

typedef AsyncCallbackWithParams<T, P extends BaseParams> = Future<T> Function(
    P b);

const throttleDuration = Duration(milliseconds: 200);

enum ComparingStatus { equal, larger, smaller }

class InfiniteListBloc<T> extends Bloc<PostEvent, InfiniteListState<T>> {
  UseCaseWrapper useCaseWrapper;
  WrapperParams wrapperParams;

  InfiniteListBloc() : super(InfiniteListState<T>()) {
    on<DataFetched>(
      _onDataFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ResetEvent>(
      _onReset,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ChangeListType>(_onChangeListType);
  }

  void buildObject(UseCaseWrapper useCaseWrapper, WrapperParams wrapperParams) {
    setUseCaseWrapper = useCaseWrapper;
    setWrapperParams = wrapperParams;
  }

  set setUseCaseWrapper(UseCaseWrapper useCaseWrapper) {
    this.useCaseWrapper = useCaseWrapper;
  }

  set setWrapperParams(WrapperParams wrapperParams) {
    this.wrapperParams = wrapperParams;
  }

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  void _onReset(ResetEvent event, Emitter<InfiniteListState<T>> emit) {
    emit(InfiniteListState<T>(listType: state.listType));
  }

  void _onChangeListType(
      ChangeListType event, Emitter<InfiniteListState<T>> emit) {
    if (event.listType == null) {
      emit(state.copyWith(
          listType:
              state.listType == ListType.list ? ListType.grid : ListType.list));
    }
    emit(state.copyWith(listType: event.listType));
  }

  Future<void> _onDataFetched(
      DataFetched event, Emitter<InfiniteListState<T>> emit) async {
    final WrapperParams params = wrapperParams.copyWith(
        startIndex: state.currentPage, extraParams: event.extraParams);
    if (state.hasReachedMax) return;
    try {
      print('state111111111111: $state');

      final data = await useCaseWrapper.caller(params);
      if (compare(data) == ComparingStatus.equal) {
        emit(state.copyWith(
          status: ListStatus.success,
          isError: false,
          currentPage: state.currentPage + 1,
          data: List.of(state.data)..addAll(data as List<T>),
          hasReachedMax: false,
        ));
        print('state222222222222: success $state');

        return;
      }

      emit(state.copyWith(
          hasReachedMax: true,
          status: compare(data) == ComparingStatus.smaller
              ? ListStatus.success
              : state.status,
          isError:
              compare(data) == ComparingStatus.smaller ? false : state.isError,
          data: compare(data) == ComparingStatus.smaller
              ? (List.of(state.data)..addAll(data as List<T>))
              : state.data));
      print('state333333333333: $state');
    } on ForbiddenError catch (e) {
      throw ForbiddenError();
    } catch (e, stacktrace) {
      print('ee: $e $stacktrace');
      emit(state.copyWith(isError: true, error: e.message.toString()));
    }
  }

  ComparingStatus compare(List<dynamic> data) {
    final length = data.length;
    final limit = (wrapperParams as PaginationParams).limit;
    if (length == limit) return ComparingStatus.equal;
    if (length < limit) return ComparingStatus.smaller;
    if (length > limit) return ComparingStatus.larger;
  }
}
