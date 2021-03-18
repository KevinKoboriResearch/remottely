abstract class UserRoutePath {}

class UsersListPath extends UserRoutePath {}

class ProfilePath extends UserRoutePath {}

class SearchPath extends UserRoutePath {}

class ShopPath extends UserRoutePath {}

class OrdersPath extends UserRoutePath {}

class Error404Path extends UserRoutePath {}

class UsersDetailsPath extends UserRoutePath {
  final int id;

  UsersDetailsPath(this.id);
}