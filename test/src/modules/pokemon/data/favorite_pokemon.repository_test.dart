import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/favorite_pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';
import 'package:pokemon_app/src/modules/pokemon/data/repositories/favorite_pokemons.repository.impl.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';

class MockFavoritePokemonsDatasource extends Mock
    implements FavoritePokemonsDatasource {}

void main() {
  late FavoritePokemonsRepository sut;
  late FavoritePokemonsDatasource datasource;
  final pokemonModel = PokemonModel(
    {"name": "pokemon1", 'id': 1},
  );
  final pokemonEntity = PokemonEntity(
    name: "pokemon1",
    id: 1,
  );
  setUp(() {
    datasource = MockFavoritePokemonsDatasource();
    sut = FavoritePokemonsRepositoryImpl(datasource);
  });

  group('Should test get pokemons', () {
    test('Should verify if datasource were called', () async {
      when(() => datasource.getPokemons()).thenAnswer(
        (_) async => [],
      );
      await sut.getPokemons();
      verify(
        () => datasource.getPokemons(),
      ).called(1);
    });

    test(
        'Should verify if datasource were called and that returns List of pokemons',
        () async {
      when(() => datasource.getPokemons()).thenAnswer(
        (_) async => [pokemonModel],
      );
      final result = await sut.getPokemons();
      result.fold((l) => fail('error'), (r) => expect(r, [pokemonModel]));
    });

    test('Should verify if datasource were called and that returns error',
        () async {
      when(() => datasource.getPokemons()).thenAnswer(
        (_) async => throw Exception(),
      );
      final result = await sut.getPokemons();
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });

  group('Should test get pokemon', () {
    test('Should verify if datasource were called', () async {
      when(() => datasource.getPokemon(1)).thenAnswer(
        (_) async => pokemonModel,
      );
      await sut.getPokemon(1);
      verify(
        () => datasource.getPokemon(1),
      ).called(1);
    });

    test(
        'Should verify if datasource were called and that returns detail of pokemons',
        () async {
      when(() => datasource.getPokemon(1)).thenAnswer(
        (_) async => pokemonModel,
      );
      final result = await sut.getPokemon(1);
      result.fold((l) => fail('error'), (r) => expect(r, pokemonModel));
    });

    test('Should verify if datasource were called and that returns error',
        () async {
      when(() => datasource.getPokemon(1)).thenAnswer(
        (_) async => throw Exception(),
      );
      final result = await sut.getPokemon(1);
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });

  group('Should test add pokemon', () {
    test('Should verify if datasource were called', () async {
      when(() => datasource.addPokemon(pokemonModel)).thenAnswer(
        (_) async => Right(null),
      );
      await sut.addPokemon(pokemonEntity);
      verify(
        () => datasource.addPokemon(pokemonModel),
      ).called(1);
    });

    test('Should verify if datasource were called and it doesn t return error',
        () async {
      when(() => datasource.addPokemon(pokemonModel)).thenAnswer(
        (_) async => pokemonModel,
      );
      final result = await sut.addPokemon(pokemonModel);
      expect(result.isRight(), true);
    });

    test('Should verify if datasource were called and that returns error',
        () async {
      when(() => datasource.addPokemon(pokemonModel)).thenAnswer(
        (_) async => throw Exception(),
      );
      final result = await sut.addPokemon(pokemonEntity);
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });

  group('Should test remove pokemon', () {
    test('Should verify if datasource were called', () async {
      when(() => datasource.removePokemon(1)).thenAnswer(
        (_) async => Right(null),
      );
      await sut.removePokemon(1);
      verify(
        () => datasource.removePokemon(1),
      ).called(1);
    });

    test('Should verify if datasource were called and it doesn t return error',
        () async {
      when(() => datasource.removePokemon(1)).thenAnswer(
        (_) async => pokemonModel,
      );
      final result = await sut.removePokemon(1);
      expect(result.isRight(), true);
    });

    test('Should verify if datasource were called and that returns error',
        () async {
      when(() => datasource.removePokemon(1)).thenAnswer(
        (_) async => throw Exception(),
      );
      final result = await sut.removePokemon(1);
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });
}
