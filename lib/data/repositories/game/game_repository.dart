import 'package:avaliacao1dm3/domain/entities/game.dart';
import 'package:avaliacao1dm3/utils/result.dart';

abstract class GameRepository {
  Future<Result<List<Game>>> getGames();
  Future<Result<Game>> getGameById(String id);
  Future<Result<void>> addGame(Game game);
  Future<Result<void>> updateGame(Game game);
  Future<Result<void>> deleteGame(String id);
}
