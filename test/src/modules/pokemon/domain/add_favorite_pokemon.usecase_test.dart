import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/add_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/add_favorite_pokemons.usecase.impl.dart';

class MockFavoritePokemonsRepository extends Mock
    implements FavoritePokemonsRepository {}

void main() {
  late AddFavoritePokemonsUsecase sut;
  late FavoritePokemonsRepository repository;
  final pokemonEntity = PokemonEntity(
    name: "pokemon1",
    id: 1,
  );

  setUp(() {
    repository = MockFavoritePokemonsRepository();
    sut = AddFavoritePokemonsUsecaseImpl(repository);
  });

  group('Should test get pokemons', () {
    test('Should verify if repository were called', () async {
      when(() => repository.addPokemon(pokemonEntity)).thenAnswer(
        (_) async => Right(null),
      );
      await sut(pokemonEntity);
      verify(
        () => repository.addPokemon(pokemonEntity),
      ).called(1);
    });

    test('Should verify if repository were called and that returns Right',
        () async {
      when(() => repository.addPokemon(pokemonEntity)).thenAnswer(
        (_) async => Right(null),
      );
      final result = await sut(pokemonEntity);
      expect(result.isRight(), true);
    });

    test('Should verify if repository were called and that returns error',
        () async {
      when(() => repository.addPokemon(pokemonEntity)).thenAnswer(
        (_) async => Left(Exception()),
      );
      final result = await sut(pokemonEntity);
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });
}
