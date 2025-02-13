import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';
import 'package:pokemon_app/src/modules/pokemon/data/repositories/pokemons.repository.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/pokemons.repository.dart';

class MockPokemonsDatasource extends Mock implements PokemonsDatasource {}

void main() {
  late PokemonsRepository sut;
  late PokemonsDatasource datasource;
  final pokemonModel = PokemonModel(
    {"name": "pokemon1", 'id': 1},
  );
  setUp(() {
    datasource = MockPokemonsDatasource();
    sut = PokemonsRepositoryImpl(datasource);
  });

  group('Should test get pokemons', () {
    test('Should verify if datasource were called', () async {
      when(() => datasource.getPokemons(offset: 0, limit: 20)).thenAnswer(
        (_) async => [],
      );
      await sut.getPokemons(offset: 0, limit: 20);
      verify(
        () => datasource.getPokemons(offset: 0, limit: 20),
      ).called(1);
    });

    test(
        'Should verify if datasource were called and that returns List of pokemons',
        () async {
      when(() => datasource.getPokemons(offset: 0, limit: 20)).thenAnswer(
        (_) async => [pokemonModel],
      );
      final result = await sut.getPokemons(offset: 0, limit: 20);
      result.fold((l) => fail('error'), (r) => expect(r, [pokemonModel]));
    });

    test('Should verify if datasource were called and that returns error',
        () async {
      when(() => datasource.getPokemons(offset: 0, limit: 20)).thenAnswer(
        (_) async => throw Exception(),
      );
      final result = await sut.getPokemons(offset: 0, limit: 20);
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });
}
