import 'package:flutter/material.dart';
import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/presentation/hom_flow/usecase/usecase_pokemon_list.dart';
import 'package:test_ososs/presentation/hom_flow/widgets/pokemon_widget.dart';
import 'package:test_ososs/presentation/infinite_list_view/entity/usecase_wrapper.dart';
import 'package:test_ososs/presentation/infinite_list_view/presentation/pagination_builder.dart';

class PokemonListPage extends StatefulWidget
{
  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  PaginationController<Results> OrdersController = PaginationController<Results>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokemons"),),
      body:  PokemonListWrapper(locator<PokemonListUseCase>()).buildPaginationList(
          controller: OrdersController,
          listBuilder: (data, index) {
            return PokmonWidget(item: data,);
          }),
    );
  }
}