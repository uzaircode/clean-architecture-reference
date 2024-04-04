import 'package:clean_architecture_rivaan/core/error/failures.dart';
import 'package:clean_architecture_rivaan/core/usecase/usecase.dart';
import 'package:clean_architecture_rivaan/core/common/entities/user.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams param) async {
    return await authRepository.currentUser();
  }
}
