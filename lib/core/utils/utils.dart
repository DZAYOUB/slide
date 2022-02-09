import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/presentation/widgets/custom_dialog.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

void showMissionCompleteDialog(BuildContext context,
    {required String title,
    required String timer,
    required String label,
    required String moves,
    required String button,
    Function()? onPressed}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => CustomDialog(
      image: 'assets/img/planet.png',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildTimer(timer, context),
          const SizedBox(height: 20),
          _buildTotalMoves(label, context, moves),
          const SizedBox(height: 20),
          SpaceButton(
              animate: false,
              onPressed: onPressed == null
                  ? () => Navigator.of(context).pop()
                  : onPressed,
              title: button),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

Container _buildTotalMoves(String label, BuildContext context, String moves) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF95119B),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 3, color: const Color(0xFFB916C1)),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
        Text(
          moves,
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Row _buildTimer(String timer, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.timer_rounded,
        color: Colors.white,
        size: 30,
      ),
      const SizedBox(width: 10),
      Text(
        timer,
        style: Theme.of(context).textTheme.headline3,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

void showCustomAlert(BuildContext context,
    {required String img,
    required String title,
    required String message,
    required String button,
    Function()? onPressed}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => CustomDialog(
      image: img,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: SpaceButton(
                onPressed: onPressed == null
                    ? () => Navigator.of(context).pop()
                    : onPressed,
                title: button),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
