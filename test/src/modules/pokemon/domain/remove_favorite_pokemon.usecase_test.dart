import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/repositories/favorite_pokemons.repository.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/remove_favorite_pokemons.usecase.dart';
import 'package:pokemon_app/src/modules/pokemon/domain/usecases/remove_favorite_pokemons.usecase.impl.dart';

class MockFavoritePokemonsRepository extends Mock
    implements FavoritePokemonsRepository {}

void main() {
  late RemoveFavoritePokemonsUsecase sut;
  late FavoritePokemonsRepository repository;

  setUp(() {
    repository = MockFavoritePokemonsRepository();
    sut = RemoveFavoritePokemonsUsecaseImpl(repository);
  });

  group('Should test get pokemons', () {
    test('Should verify if repository were called', () async {
      when(() => repository.removePokemon(1)).thenAnswer(
        (_) async => Right(null),
      );
      await sut(1);
      verify(
        () => repository.removePokemon(1),
      ).called(1);
    });

    test('Should verify if repository were called and that returns Right',
        () async {
      when(() => repository.removePokemon(1)).thenAnswer(
        (_) async => Right(null),
      );
      final result = await sut(1);
      expect(result.isRight(), true);
    });

    test('Should verify if repository were called and that returns error',
        () async {
      when(() => repository.removePokemon(1)).thenAnswer(
        (_) async => Left(Exception()),
      );
      final result = await sut(1);
      result.fold((l) => expect(l, isA<Exception>()), (r) => fail('error'));
    });
  });
}
