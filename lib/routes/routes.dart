abstract class UserRoutePath {}

class UsersListPath extends UserRoutePath {}

class UsersSettingsPath extends UserRoutePath {}

class Error404Path extends UserRoutePath {}

class UsersDetailsPath extends UserRoutePath {
  final int id;

  UsersDetailsPath(this.id);
}