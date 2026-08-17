import 'package:avaliacao1dm3/routing/routing.dart';
import 'package:avaliacao1dm3/ui/core/components/components.dart';
import 'package:avaliacao1dm3/ui/home/components/game_tile.dart';
import 'package:avaliacao1dm3/ui/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Jogos'
        ),
      ),
      body: ListenableBuilder(
        listenable: widget.homeViewModel.load,
        builder: (context, child) {
          if (widget.homeViewModel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.homeViewModel.load.error) {
            return Center(
              child: ErrorComponent(
                title: 'Ocorreu um problema ao buscar os jogos.',
                label: 'Tentar novamente',
                onPressed: () {
                  widget.homeViewModel.load.execute();
                },
              ),
            );
          }

          if (widget.homeViewModel.games.isEmpty) {
            return Center(
              child: Text(
                'Nenhum jogo cadastrado.\nPressione o botão "+" para adicionar.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: widget.homeViewModel.games.length,
            itemBuilder: (context, index) {
              final game = widget.homeViewModel.games[index];
              return GameTile(
                game: game,
                onTap: () {
                  context.push(Routes.gameDetailsById(game.id));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          context.go(Routes.addGame);
        },
      ),
    );
  }
}