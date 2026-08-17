import 'package:avaliacao1dm3/data/repositories/game/game_repository.dart';
import 'package:avaliacao1dm3/domain/entities/game.dart';
import 'package:avaliacao1dm3/utils/command.dart';
import 'package:avaliacao1dm3/utils/result.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required GameRepository gameRepository,
  }) : _gameRepository = gameRepository {
    load = Command0(_load)..execute();
    deleteGame = Command1(_deleteGame);
  }

  final GameRepository _gameRepository;

  late Command0 load;
  late Command1<void, String> deleteGame;

  List<Game> get games => _games;
  List<Game> _games = [];

  Future<Result> _load() async {
    try {
      final result = await _gameRepository.getGames();
      if (result is Ok<List<Game>>) {
        _games = result.value;
      }

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteGame(String gameId) async {
    try {
      final result = await _gameRepository.deleteGame(gameId);
      if (result is Error<void>) {
        return result;
      }

      final gamesResult = await _load();

      if (gamesResult is Ok<List<Game>>) {
        _games = gamesResult.value;
      }
      return gamesResult;
    } finally {
      notifyListeners();
    }
  }

}
