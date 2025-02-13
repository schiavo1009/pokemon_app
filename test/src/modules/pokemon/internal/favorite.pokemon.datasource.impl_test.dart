import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/core/db/db_client.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/favorite_pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';
import 'package:pokemon_app/src/modules/pokemon/internal/favorite_pokemons.datasource.impl.dart';

class MockDbClient extends Mock implements DbClient {}

void main() {
  late FavoritePokemonsDatasource sut;
  late MockDbClient mockDbClient;
  final listResponseData =
      List.generate(2, (index) => {"name": "pokemon$index", "id": index + 1});

  final pokemonResponseData = {"name": "pokemon0", 'id': 1};
  setUp(() {
    mockDbClient = MockDbClient();
    sut = FavoritePokemonsDatasourceImpl(mockDbClient);
  });

  group('Should test getPokemons', () {
    test('Should call getPokemons and that returns a list of pokemons',
        () async {
      when(() => mockDbClient.query())
          .thenAnswer((_) async => listResponseData);

      final result = await sut.getPokemons();

      verify(() => mockDbClient.query()).called(1);
      expect(result, isA<List<PokemonModel>>());
      expect(result.length, 2);
      expect(result.first.name, 'pokemon0');
      expect(result.first.id, 1);
      expect(result.last.name, 'pokemon1');
      expect(result.last.id, 2);
    });

    test('Should call getPokemons and that returns a error', () async {
      when(() => mockDbClient.query())
          .thenAnswer((_) async => throw Exception());
      expect(() => sut.getPokemons(), throwsA(isA<Exception>()));
    });
  });

  group('Should test getPokemon', () {
    test('Should call getPokemon and that return a pokemon', () async {
      when(() => mockDbClient.getItemFromID('1'))
          .thenAnswer((_) async => pokemonResponseData);

      final result = await sut.getPokemon(1);

      verify(() => mockDbClient.getItemFromID('1')).called(1);
      expect(result, isA<PokemonModel>());
    });

    test('Should call getPokemon and that return a error', () async {
      when(() => mockDbClient.getItemFromID('1'))
          .thenAnswer((_) async => throw Exception());
      expect(() => sut.getPokemon(1), throwsA(isA<Exception>()));
    });
  });

  group('Should test getPokemon', () {
    test('Should call getPokemon and that return a pokemon', () async {
      when(() => mockDbClient.getItemFromID('1'))
          .thenAnswer((_) async => pokemonResponseData);

      final result = await sut.getPokemon(1);

      verify(() => mockDbClient.getItemFromID('1')).called(1);
      expect(result, isA<PokemonModel>());
    });

    test('Should call getPokemon and that return a error', () async {
      when(() => mockDbClient.getItemFromID('1'))
          .thenAnswer((_) async => throw Exception());
      expect(() => sut.getPokemon(1), throwsA(isA<Exception>()));
    });
  });

  group('Should test add pokemon', () {
    test('Should call addPokemon', () async {
      when(() => mockDbClient.insert(pokemonResponseData))
          .thenAnswer((_) async => pokemonResponseData);
      await sut.addPokemon(PokemonModel(pokemonResponseData));
      verify(() => mockDbClient.insert(pokemonResponseData)).called(1);
      expect(
          () async => await sut.addPokemon(PokemonModel(pokemonResponseData)),
          returnsNormally);
    });

    test('Should call addPokemon and that return a error', () async {
      when(() => mockDbClient.insert(pokemonResponseData))
          .thenAnswer((_) async => throw Exception());
      expect(() => sut.addPokemon(PokemonModel(pokemonResponseData)),
          throwsA(isA<Exception>()));
    });
  });

  group('Should test remove pokemon', () {
    test('Should call removePokemon and that return a pokemon', () async {
      when(() => mockDbClient.delete(1))
          .thenAnswer((_) async => pokemonResponseData);
      await sut.removePokemon(1);
      verify(() => mockDbClient.delete(1)).called(1);
      expect(() async => await sut.removePokemon(1), returnsNormally);
    });

    test('Should call removePokemon and that return a error', () async {
      when(() => mockDbClient.delete(1))
          .thenAnswer((_) async => throw Exception());
      expect(() => sut.removePokemon(1), throwsA(isA<Exception>()));
    });
  });
}
