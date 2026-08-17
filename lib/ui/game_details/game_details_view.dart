import 'package:avaliacao1dm3/ui/game_form/game_form_view.dart';
import 'package:avaliacao1dm3/ui/game_form/view_models/game_form_view_model.dart';
import 'package:flutter/material.dart';

class GameDetailsView extends StatefulWidget {
  const GameDetailsView({
    super.key,
    required this.gameFormViewModel,
  });

  final GameFormViewModel gameFormViewModel;

  @override
  State<GameDetailsView> createState() => _GameDetailsViewState();
}

class _GameDetailsViewState extends State<GameDetailsView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: GameFormView(
        enableDelete: true,
        viewModel: widget.gameFormViewModel,
      ),
    );
  }
}