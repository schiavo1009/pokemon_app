import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemon.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_favorite_pokemon.usecase.impl.dart';

class MockFavoritePokemonsRepository extends Mock
    implements FavoritePokemonsRepository {}

void main() {
  late GetFavoritePokemonUsecase sut;
  late FavoritePokemonsRepository repository;
  final pokemonEntity = PokemonEntity(
    name: "pokemon1",
    id: 1,
  );

  setUp(() {
    repository = MockFavoritePokemonsRepository();
    sut = GetFavoritePokemonUsecaseImpl(repository);
  });

  group('Should test get pokemons', () {
    test('Should verify if repository were called', () async {
      when(() => repository.getPokemon(1)).thenAnswer(
        (_) async => Right(pokemonEntity),
      );
      await sut(1);
      verify(
        () => repository.getPokemon(1),
      ).called(1);
    });

    test(
        'Should verify if repository were called and that returns List of pokemons',
        () async {
      when(() => repository.getPokemon(1)).thenAnswer(
        (_) async => Right(pokemonEntity),
      );
      final result = await sut(1);
      result.fold((l) => fail('error'), (r) => expect(r, pokemonEntity));
    });

    test('Should verify if repository were called and that returns error',
        () async {
      when(() => repository.getPokemon(1)).thenAnswer(
        (_) async => Left(Exception()),
      );
      final result = await sut(1);
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });
}
