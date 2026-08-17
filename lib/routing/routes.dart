abstract final class Routes {
  static const String home = '/';
  static const String addGame = 'add-game';
  static const String gameDetails = 'game-details/:id';
  static String gameDetailsById(String id) => 'game-details/$id';
}
