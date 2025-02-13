import 'package:pokemon_app/src/core/endpoint/endpoints.core.dart';

class EndpointsCoreImpl implements EndpointsCore {
  
  @override
  String getImagePath(int numberPokemon) =>
     'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$numberPokemon.png';
  
  @override
  String get basePath => 'https://pokeapi.co/api/v2/';
  
}
