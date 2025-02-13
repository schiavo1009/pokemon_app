import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/entities/pokemon.entity.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemon.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/get_pokemon.usecase.impl.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  late GetPokemonUsecase sut;
  late PokemonsRepository repository;
  final pokemonEntity = PokemonEntity(
    name: "pokemon1",
    id: 1,
  );

  setUp(() {
    repository = MockPokemonsRepository();
    sut = GetPokemonUsecaseImpl(repository);
  });

  group('Should test get pokemons', () {
    test('Should verify if repository were called', () async {
      when(() => repository.getPokemon('1')).thenAnswer(
        (_) async => Right(pokemonEntity),
      );
      await sut('1');
      verify(
        () => repository.getPokemon('1'),
      ).called(1);
    });

    test(
        'Should verify if repository were called and that returns detail of pokemons',
        () async {
      when(() => repository.getPokemon('1')).thenAnswer(
        (_) async => Right(pokemonEntity),
      );
      final result = await sut('1');
      result.fold((l) => fail('error'), (r) => expect(r, pokemonEntity));
    });

    test('Should verify if repository were called and that returns error',
        () async {
      when(() => repository.getPokemon('1')).thenAnswer(
        (_) async => Left(Exception()),
      );
      final result = await sut('1');
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });
}
