import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_Page> _pages = [
    _Page(icon: Icons.code_rounded, title: 'Smart Code Docs', description: 'Auto-generate comprehensive documentation from your code. Supports all major languages and frameworks.', color: const Color(0xFF10B981)),
    _Page(icon: Icons.description_rounded, title: 'README Generator', description: 'Create professional README files with badges, installation guides, and API references in seconds.', color: const Color(0xFF34D399)),
    _Page(icon: Icons.architecture_rounded, title: 'Architecture Analysis', description: 'Understand your codebase architecture with AI-generated diagrams, patterns, and improvement suggestions.', color: const Color(0xFF6EE7B7)),
  ];

  void _goToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: _goToHome, child: const Text('Skip', style: TextStyle(color: Color(0xFF10B981), fontSize: 16, fontFamily: 'monospace'))),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) {
                  final page = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140, height: 140,
                          decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [page.color.withOpacity(0.3), page.color.withOpacity(0.05)])),
                          child: Icon(page.icon, size: 70, color: page.color),
                        ),
                        const SizedBox(height: 50),
                        Text(page.title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
                        const SizedBox(height: 20),
                        Text(page.description, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[400], fontSize: 16, height: 1.6, fontFamily: 'monospace')),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: List.generate(_pages.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 8),
                    width: _currentPage == i ? 28 : 10, height: 10,
                    decoration: BoxDecoration(color: _currentPage == i ? const Color(0xFF10B981) : const Color(0xFF1A2F22), borderRadius: BorderRadius.circular(5)),
                  ))),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) _goToHome();
                      else _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                    },
                    child: Text(_currentPage == _pages.length - 1 ? './start' : './next', style: const TextStyle(fontFamily: 'monospace')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Page {
  final IconData icon; final String title; final String description; final Color color;
  _Page({required this.icon, required this.title, required this.description, required this.color});
}
