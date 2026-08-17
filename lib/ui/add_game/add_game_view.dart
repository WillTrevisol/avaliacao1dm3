import 'package:avaliacao1dm3/ui/game_form/game_form_view.dart';
import 'package:avaliacao1dm3/ui/game_form/view_models/game_form_view_model.dart';
import 'package:flutter/material.dart';

class AddGameView extends StatefulWidget {
  const AddGameView({
    super.key,
    required this.gameFormViewModel,
  });

  final GameFormViewModel gameFormViewModel;

  @override
  State<AddGameView> createState() => _AddGameViewState();
}

class _AddGameViewState extends State<AddGameView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar jogo'),
      ),
      body: GameFormView(viewModel: widget.gameFormViewModel),
    );
  }
}