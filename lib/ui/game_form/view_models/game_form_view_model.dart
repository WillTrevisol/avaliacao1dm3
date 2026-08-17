import 'package:avaliacao1dm3/data/repositories/game/game_repository.dart';
import 'package:avaliacao1dm3/domain/entities/game.dart';
import 'package:avaliacao1dm3/utils/command.dart';
import 'package:avaliacao1dm3/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GameFormViewModel extends ChangeNotifier {
  GameFormViewModel({
    required GameRepository gameRepository,
    String? gameId
  }): _gameRepository = gameRepository {
    save = Command0(_save);
    fetch = Command1(_fetch);
    delete = Command0(_delete);
    if (gameId != null) {
      _gameId = gameId;
      fetch.execute(gameId);
    }
  }

  final GameRepository _gameRepository;

  late Command0 save;
  late Command1<void, String> fetch;
  late Command0 delete;

  Game game = Game();
  String? _gameId;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController platformController = TextEditingController();

  void updateGameStatus(double value) {
    game.completed = value.truncate();
    notifyListeners();
  }

  Future<Result<void>> _save() async {
    try {
      if (titleController.text.isEmpty) {
        return Result.error(ErrorMessage(message: 'O campo título é obrigatório'));
      }

      if (platformController.text.isEmpty) {
        return Result.error(ErrorMessage(message: 'O campo plataforma é obrigatório'));
      }

      game.id = _gameId ?? Uuid().v1();
      game.title = titleController.text;
      game.platform = platformController.text;

      late Result result;
      if (_gameId != null) {
        result = await _gameRepository.updateGame(game);
      } else {
        result = await _gameRepository.addGame(game);
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<Game>> _fetch(String id) async {
    try {
      final result = await _gameRepository.getGameById(id);
      if (result is Ok<Game>) {
        game = result.value;
        titleController.text = game.title;
        platformController.text = game.platform;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _delete() async {
    try {
      final result = await _gameRepository.deleteGame(_gameId ?? game.id);
      return result;
    } finally {
      notifyListeners();
    }
  }

}
