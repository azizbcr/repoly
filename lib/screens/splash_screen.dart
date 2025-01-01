import 'package:flutter/material.dart';
import 'material_library_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueGrey.shade900,
              Colors.black,
              Colors.black,
              Colors.teal.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Arka plan partikülleri
              ...List.generate(20, (index) {
                return Positioned(
                  left: index * 20.0,
                  top: index * 30.0,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),

              Column(
                children: [
                  // Üst kısımdaki geri butonu
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.white70),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MaterialLibraryScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Logo ve içerik
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Animasyonlu logo
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Transform.rotate(
                                  angle: _rotateAnimation.value,
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.tealAccent.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            Colors.tealAccent.withOpacity(0.3),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.tealAccent
                                              .withOpacity(0.2),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.polymer,
                                      size: 100,
                                      color: Colors.tealAccent,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 50),

                          // Uygulama adı
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.tealAccent.shade400,
                                Colors.tealAccent.shade200,
                              ],
                            ).createShader(bounds),
                            child: const Text(
                              'RePoly',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Alt başlık
                          Text(
                            'Polimer Malzeme Kütüphanesi',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade400,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 60),

                          // Başla butonu
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.tealAccent.shade700,
                                  Colors.tealAccent.shade400,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.tealAccent.withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MaterialLibraryScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 48,
                                  vertical: 16,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'BAŞLA',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Alt bilgi
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'v1.0.0',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
