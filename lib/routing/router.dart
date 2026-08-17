
import 'package:avaliacao1dm3/routing/routing.dart';
import 'package:avaliacao1dm3/ui/add_game/add_game_view.dart';
import 'package:avaliacao1dm3/ui/game_details/game_details_view.dart';
import 'package:avaliacao1dm3/ui/game_form/view_models/game_form_view_model.dart';
import 'package:avaliacao1dm3/ui/home/home_view.dart';
import 'package:avaliacao1dm3/ui/home/view_models/home_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract final class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          final HomeViewModel homeViewModel = HomeViewModel(gameRepository: context.read());
          return HomeView(homeViewModel: homeViewModel);
        },
        routes: [
          GoRoute(
            path: Routes.addGame,
            builder: (context, state) {
              final GameFormViewModel gameFormViewModel = GameFormViewModel(gameRepository: context.read());
              return AddGameView(gameFormViewModel: gameFormViewModel);
            }
          ),
          GoRoute(
            path: Routes.gameDetails,
            builder: (context, state) {
              String? gameId = state.pathParameters['id'];
              final GameFormViewModel gameFormViewModel = GameFormViewModel(gameRepository: context.read(), gameId: gameId);
              return GameDetailsView(gameFormViewModel: gameFormViewModel);
            },
          ),
        ]
      ),
    ],
  );
}
