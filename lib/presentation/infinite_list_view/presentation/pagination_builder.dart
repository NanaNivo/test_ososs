import 'dart:ffi';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:test_ososs/presentation/infinite_list_view/bloc/infinite_list_bloc.dart';
import 'package:test_ososs/presentation/infinite_list_view/entity/pagination_params.dart';
import 'package:test_ososs/presentation/infinite_list_view/presentation/widgets/error_widget.dart';

import '../entity/usecase_wrapper.dart';
import 'widgets/bottom_loader.dart';

typedef PaginationType<T> = Widget Function(T data, int index);

class PaginationController<T> {
  PostsListState<T> _state;

  void setData(PostsListState<T> state) {
    _state = state;
  }

  void getData(Map<String, dynamic> extraParams) {
    _state.callEvent(extraParams);
  }

  void changeListType({ListType listType}) {
    _state.changeListType(listType: listType);
  }

}

class PaginationBuilder<T> extends StatefulWidget {
  const PaginationBuilder({
    Key key,
    @required this.gridBuilder,
    @required this.listBuilder,
    @required this.useCase,
    this.withError = true,
    this.scrollDirection = Axis.vertical,
    this.extraParams = const {},
    this.controller,
    this.flex = 1,
    this.callEvent,
    this.type = ListType.grid,
  }) : super(key: key);
  final PaginationType<T> gridBuilder;
  final PaginationType<T> listBuilder;
  final UseCaseWrapper useCase;
  final Map<String, dynamic> extraParams;
  final Axis scrollDirection;
  final bool withError;
  final ListType type;
  final int flex;
  final VoidCallback callEvent;
  final PaginationController<T> controller;

  @override
  State<PaginationBuilder<T>> createState() => PostsListState<T>();
}

class PostsListState<T> extends State<PaginationBuilder<T>>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  AnimationController listAnimationController;
  AnimationController gridAnimationController;

  InfiniteListBloc bloc = InfiniteListBloc();

  @override
  void initState() {

    if (widget.controller != null) {
      widget.controller.setData(this);
    }
    listAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    gridAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    bloc.buildObject(widget.useCase, PaginationParams());
    super.initState();
    _scrollController.addListener(_onScroll);
    changeListType(listType: widget.type);
    bloc.add(DataFetched(extraParams: widget.extraParams));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfiniteListBloc, InfiniteListState>(
      listener: (context, state) {
        if (state.isError && state.data.isNotEmpty) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.error.toString()),
              duration: const Duration(seconds: 2),
              backgroundColor: locator<AppThemeColors>().primaryColor));
        }
      },
      bloc: bloc,
      builder: (context, state) {
        print("Conterxtttoototooto ${state}");
        if (state.isError && state.data.isEmpty) {
          return Visibility(
              visible: widget.withError,
              child: PaginationError(error: state.error));
        }
        switch (state.status) {
          case ListStatus.success:
            if (state.data.isEmpty) {
              return Visibility(
                  visible: widget.withError,
                  child: const PaginationError(error: "There is no data"));
            }
            if (state.listType == ListType.list) {
              print(state);
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                scrollDirection: widget.scrollDirection,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      state.data.length > 10 ? 10 : state.data.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: listAnimationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  listAnimationController?.forward();

                    return index >= state.data.length
                        ? const BottomLoader()
                        : AnimatedBuilder(
                          animation: listAnimationController,
                          builder: (BuildContext context, Widget child) {
                            return FadeTransition(
                                opacity: animation,
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      100 * (1.0 - animation.value), 0.0, 0.0),
                                  child: widget.listBuilder(
                                      (state.data[index]), index),
                                ));
                          });
                },
                itemCount: state.hasReachedMax
                    ? state.data.length
                    : state.data.length + 1,
                controller: _scrollController,
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: state.hasReachedMax
                  ? state.data.length
                  : state.data.length + 1,
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (BuildContext context, int index) {
                final int count =
                state.data.length > 10 ? 10 : state.data.length;
                final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: gridAnimationController,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                gridAnimationController?.forward();
                return index == state.data.length
                    ? const BottomLoader()
                    :  AnimatedBuilder(
                    animation: gridAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return FadeTransition(
                          opacity: animation,
                          child: Transform(
                            transform: Matrix4.translationValues(
                                100 * (1.0 - animation.value), 0.0, 0.0),
                            child: widget.gridBuilder(
                                (state.data[index]), index),
                          ));
                    });
              },
            );
          case ListStatus.initial:
            return Visibility(
              visible: widget.withError,
              child: Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                      color: locator<AppThemeColors>().primaryColor, size: 50)),
            );
          default:
            return Visibility(visible: false, child: Container());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    gridAnimationController?.dispose();
    listAnimationController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) bloc.add(DataFetched(extraParams: widget.extraParams));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }



  void callEvent(Map<String, dynamic> extraParams) {
    bloc.add(ResetEvent());
    bloc.add(DataFetched(extraParams: extraParams));
  }

  void changeListType({ListType listType}) {
   gridAnimationController?.reverse();
   listAnimationController?.reverse();
    bloc.add(ChangeListType(listType));
  }
}
