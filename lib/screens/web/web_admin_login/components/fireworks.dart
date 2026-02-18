import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';

class FireworksBackground extends StatefulWidget {
  final Widget child;
  const FireworksBackground({super.key, required this.child});

  @override
  State<FireworksBackground> createState() => _FireworksBackgroundState();
}

class _FireworksBackgroundState extends State<FireworksBackground> {
  late ConfettiController controller;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: Duration(seconds: 30));
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            numberOfParticles: 100,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
