import 'package:avaliacao1dm3/data/datasources/local_datasource.dart';
import 'package:avaliacao1dm3/data/repositories/game/game_repository.dart';
import 'package:avaliacao1dm3/domain/entities/game.dart';
import 'package:avaliacao1dm3/utils/result.dart';

class GameRepositoryLocal implements GameRepository {
  GameRepositoryLocal({required this.localDatasource});

  final LocalDatasource localDatasource;

  @override
  Future<Result<void>> addGame(Game game) async {
    final database = await localDatasource.database;
    final result = await database.insert(LocalDatasource.gameTable, game.toMap());
    if (result != 0) {
      return Result<Game>.ok(game);
    } else {
      return Result.error(Exception('Failed to add game'));
    }
  }

  @override
  Future<Result<void>> deleteGame(String id) async {
    final database = await localDatasource.database;
    final result = await database.delete(LocalDatasource.gameTable, where: '${LocalDatasource.idColumn} = ?', whereArgs: [id]);
    if (result > 0) {
      return Result<void>.ok(null);
    } else {
      return Result.error(Exception('Failed to delete game'));
    }
  }

  @override
  Future<Result<Game>> getGameById(String id) async {
    final database = await localDatasource.database;
    final result = await database.query(LocalDatasource.gameTable, where: '${LocalDatasource.idColumn} = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      final game = Game.fromMap(result.first);
      return Result<Game>.ok(game);
    } else {
      return Result.error(Exception('Game not found'));
    }
  }

  @override
  Future<Result<List<Game>>> getGames() async {
    final database = await localDatasource.database;
    final result = await database.query(LocalDatasource.gameTable);
    final games = result.map((row) => Game.fromMap(row)).toList();
    return Result<List<Game>>.ok(games);
  }

  @override
  Future<Result<void>> updateGame(Game game) async {
    final database = await localDatasource.database;
    final result = await database.update(
      LocalDatasource.gameTable,
      game.toMap(),
      where: '${LocalDatasource.idColumn} = ?',
      whereArgs: [game.id]
    );
    if (result > 0) {
      return Result<Game>.ok(game);
    } else {
      return Result.error(Exception('Failed to update game'));
    }
  }


}
