import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:slide_puzzle_game/presentation/views/difficulty_view.dart';
import 'package:slide_puzzle_game/presentation/views/history/history_view.dart';
import 'package:slide_puzzle_game/presentation/widgets/home_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          HomeViewBackground(),
          HomeViewBody(),
        ],
      ),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/audio/space_coin.mp3');
    context.read<AudioCubit>().playMenuMusic();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 10);
    const duration = 800;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpaceBar(),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: (MediaQuery.of(context).size.width / 2).clamp(200, 300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlayButton(
                      onPressed: () => pushView(child: const DifficultyView()),
                    ),
                    const SizedBox(height: 30),
                    SpaceButton(
                      title: AppLocalizations.of(context).homeRanking,
                      padding: padding,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    SpaceButton(
                      title: AppLocalizations.of(context).homeHistory,
                      padding: padding,
                      duration: const Duration(milliseconds: duration * 2),
                      onPressed: () => pushView(child: const HistoryView()),
                    ),
                    const SizedBox(height: 30),
                    SpaceButton(
                      title: AppLocalizations.of(context).homeCredits,
                      padding: padding,
                      duration: const Duration(milliseconds: duration * 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void pushView({required Widget child}) {
    player.replay(context);
    Navigator.of(context).push<void>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: playButtonDecoration,
        child: const Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 120,
        ),
      ),
    );
  }
}
