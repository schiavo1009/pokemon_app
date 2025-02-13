import 'package:dartz/dartz.dart';

abstract class RemoveFavoritePokemonsUsecase {
  Future<Either<Exception, void>> call(int id 
     );
}
