part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

//the app user initial is when user log out
final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;
  AppUserLoggedIn(this.user);
}
