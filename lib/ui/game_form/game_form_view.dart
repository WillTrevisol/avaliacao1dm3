import 'package:avaliacao1dm3/ui/game_form/view_models/game_form_view_model.dart';
import 'package:avaliacao1dm3/ui/core/components/components.dart';
import 'package:avaliacao1dm3/ui/core/components/label_title.dart';
import 'package:avaliacao1dm3/ui/core/themes/themes.dart';
import 'package:avaliacao1dm3/utils/loading_helper.dart';
import 'package:avaliacao1dm3/utils/result.dart' as result;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameFormView extends StatefulWidget {
  const GameFormView({super.key, required this.viewModel, this.enableDelete = false});

  final GameFormViewModel viewModel;
  final bool enableDelete;

  @override
  State<GameFormView> createState() => GameFormViewState();
}

class GameFormViewState extends State<GameFormView> with LoadingHelper {

  @override
  void initState() {
    super.initState();
    widget.viewModel.save.addListener(onResult);
    widget.viewModel.delete.addListener(onDeleteResult);
  }

  @override
  void dispose() {
    widget.viewModel.titleController.dispose();
    widget.viewModel.platformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelTitle(text: 'Título'),
          const SizedBox(height: 8),
          DefaultTextField(
            controller: widget.viewModel.titleController,
            hint: 'Ex: Cyberpunk 2077',
          ),
          const SizedBox(height: 24),
          LabelTitle(text: 'Plataforma'),
          const SizedBox(height: 8),
          DefaultTextField(
            controller: widget.viewModel.platformController,
            hint:'Ex: Steam, PS5, Switch...',
          ),
          const SizedBox(height: 24),
          LabelTitle(text: 'Status de Conclusão'),
          const SizedBox(height: 8),
          ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) {
              return SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: const Color(0xFF252525),
                  thumbColor: AppColors.primary,
                  trackHeight: 6,
                  overlayShape: SliderComponentShape.noThumb,
                ),
                child: Slider(
                  value: widget.viewModel.game.completed.toDouble(),
                  min: 0,
                  max: 100,
                  onChanged: widget.viewModel.updateGameStatus,
                ),
              );
            }
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0%', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
              Text('50%', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
              Text('100%', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () => widget.viewModel.save.execute(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.save, size: 20),
              label: const Text(
                'Salvar Jogo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          if (widget.enableDelete) ... {
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => showDeleteConfirmation(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.delete_forever, size: 22),
                label: const Text(
                  'Deletar Jogo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          },
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  

  void onResult() {
    if (widget.viewModel.save.running) {
      showLoading(context);
    } else {
      hideLoading(context);
    }

    if (widget.viewModel.save.completed) {
      widget.viewModel.save.clearResult();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jogo salvo com sucesso.')),
      );
      context.pop();
    }

    if (widget.viewModel.save.error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((widget.viewModel.save.result as result.Error<void>).error.toString()),
        ),
      );
      widget.viewModel.save.clearResult();
    }
  }

  void onDeleteResult() {
    if (widget.viewModel.delete.completed) {
      showLoading(context);
    } else {
      hideLoading(context);
    }

    if (widget.viewModel.delete.completed) {
      widget.viewModel.save.clearResult();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jogo removido com sucesso.')),
      );
      context.pop();
    }

    if (widget.viewModel.delete.error) {
      widget.viewModel.save.clearResult();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover jogo.')),
      );
    }
  }

  Future<void> showDeleteConfirmation() async {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.maxFinite,
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Flexible(
                  child: Text(
                    'Tem certeza que deseja remover o jogo?',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      widget.viewModel.delete.execute();
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.check, size: 22),
                    label: const Text(
                      'Confirmar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: context.pop,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.cancel, size: 22),
                    label: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}