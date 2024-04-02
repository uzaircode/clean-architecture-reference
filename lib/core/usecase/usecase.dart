import 'package:clean_architecture_rivaan/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

// usecase expose a high level functionality, exp. sign up
// usecase must be generic
// successType - depends on the usecase, cannot be hard coded
// Params - every function/usecase have different parameters
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params param);
}
