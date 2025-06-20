import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  int _currentStage = 0;
  final List<double> _stageDurations = [1.5, 1.5, 1.5]; // Total 4.5 seconds

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _startAnimation();
  }

  void _startAnimation() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (_currentStage < _stageDurations.length - 1) {
        setState(() {
          _currentStage++;
        });
        _controller.reset();
        _controller.forward();
      } else {
        timer.cancel();
        // Navigate to next screen after animation completes
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacementNamed('/home');
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _buildStageContent(),
        ),
      ),
    );
  }

  Widget _buildStageContent() {
    switch (_currentStage) {
      case 0:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: const _EquationWidget(),
          ),
        );
      case 1:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: const _LogoWidget(),
          ),
        );
      case 2:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: const _PoweredByWidget(),
          ),
        );
      default:
        return const _PoweredByWidget();
    }
  }
}

class _EquationWidget extends StatelessWidget {
  const _EquationWidget();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'Assets/logo_login_screen.png',
      height: 120,
    );
  }
}

class _PoweredByWidget extends StatelessWidget {
  const _PoweredByWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: Stack(
        children: [
          // Main content centered
          Center(
            child: Image.asset(
              'Assets/logo_login_screen.png',
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.medical_services, size: 100);
              },
            ),
          ),
          // Powered By section at bottom
          Positioned(
            bottom: 40, // Adjust this value to change distance from bottom
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // NextGen Team Logo
                Image.asset(
                  'Assets/Team_logo.png',
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                        'NextGen Team',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    );
                  },
                ),
                const Column(
                  children: [
                    // Powered By Text
                    Text(
                      'Powered By',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'NexGen Team',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}