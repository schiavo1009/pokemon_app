import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/src/modules/pokemon/data/datasources/pokemons.datasource.dart';
import 'package:pokemon_app/src/modules/pokemon/data/models/pokemon.model.dart';
import 'package:pokemon_app/src/modules/pokemon/external/pokemons.datasource.impl.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late PokemonsDatasource sut;
  late MockDio mockDio;
  final offset = 0;
  final limit = 20;
  final listResponseData = {
    "results": List.generate(2, (index) => {"name": "pokemon$index"})
  };
  final pokemonResponseData = {"name": "pokemon0", 'id': 1};
  setUp(() {
    mockDio = MockDio();
    sut = PokemonsDatasourceImpl(mockDio);
  });

  group('Should test getPokemons', () {
    test('Should call getPokemons and that returns a list of pokemons',
        () async {
      when(() => mockDio.get(PokemonsDatasourceImpl.route, queryParameters: {
            "offset": offset,
            "limit": limit,
          })).thenAnswer((_) async => Response(
            data: listResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await sut.getPokemons(limit: limit, offset: offset);

      verify(() => mockDio.get(PokemonsDatasourceImpl.route, queryParameters: {
            "offset": offset,
            "limit": limit,
          })).called(1);
      expect(result, isA<List<PokemonModel>>());
      expect(result.length, 2);
      expect(result.first.name, 'pokemon0');
      expect(result.first.id, 1);
      expect(result.last.name, 'pokemon1');
      expect(result.last.id, 2);
    });

    test('Should call getPokemons and that returns a error', () async {
      when(() => mockDio.get(PokemonsDatasourceImpl.route, queryParameters: {
            "offset": offset,
            "limit": limit,
          })).thenAnswer((_) async => Response(
            data: null,
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ));
      expect(() => sut.getPokemons(offset: offset, limit: limit),
          throwsA(isA<Exception>()));
    });
  });

  group('Should test getPokemon', () {
    test('Should call getPokemon and that return a pokemon', () async {
      when(() => mockDio.get('${PokemonsDatasourceImpl.route}/1'))
          .thenAnswer((_) async => Response(
                data: pokemonResponseData,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await sut.getPokemon('1');

      verify(() => mockDio.get('${PokemonsDatasourceImpl.route}/1')).called(1);
      expect(result, isA<PokemonModel>());
    });

    test('Should call getPokemon and that return a error', () async {
      when(() => mockDio.get('${PokemonsDatasourceImpl.route}/1'))
          .thenAnswer((_) async => Response(
                data: null,
                statusCode: 400,
                requestOptions: RequestOptions(path: ''),
              ));
      expect(() => sut.getPokemon('1'), throwsA(isA<Exception>()));
    });
  });
}
