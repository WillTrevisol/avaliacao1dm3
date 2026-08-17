

import 'package:avaliacao1dm3/data/datasources/local_datasource.dart';
import 'package:avaliacao1dm3/data/repositories/game/game_repository.dart';
import 'package:avaliacao1dm3/data/repositories/game/game_repository_local.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get localProviders => [
  Provider.value(value: LocalDatasource()),
  Provider(
    create: (context) => GameRepositoryLocal(localDatasource: context.read()) as GameRepository,
  ),
];