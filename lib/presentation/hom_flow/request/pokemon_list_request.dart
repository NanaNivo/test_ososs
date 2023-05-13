class PokemonRequest {
  // CoverageModel coverageModel;
final int page;
  PokemonRequest({this.page});

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{
      'limit':10,
      'offset':this.page,
    };
    return data;
  }
}