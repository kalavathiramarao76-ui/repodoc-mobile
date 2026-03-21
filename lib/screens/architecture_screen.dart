import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class ArchitectureScreen extends StatefulWidget {
  const ArchitectureScreen({super.key});

  @override
  State<ArchitectureScreen> createState() => _ArchitectureScreenState();
}

class _ArchitectureScreenState extends State<ArchitectureScreen> {
  final _codeController = TextEditingController();
  String _result = '';
  bool _isLoading = false;

  Future<void> _analyze() async {
    if (_codeController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.analyzeArchitecture(_codeController.text.trim());
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() { _codeController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      appBar: AppBar(title: const Text('Architecture Analyzer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TerminalCard(
              title: 'repodoc-arch',
              content: '\$ repodoc arch --analyze\n> Paste code or describe structure\n> Design patterns detected\n> ASCII architecture diagrams',
            ),
            const SizedBox(height: 20),

            // Architecture pattern cards
            const SectionHeader(title: 'Common Patterns', icon: Icons.pattern_rounded),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPatternChip('MVC', Icons.view_module_rounded),
                  const SizedBox(width: 10),
                  _buildPatternChip('Microservices', Icons.hub_rounded),
                  const SizedBox(width: 10),
                  _buildPatternChip('Clean Arch', Icons.layers_rounded),
                  const SizedBox(width: 10),
                  _buildPatternChip('Event-Driven', Icons.bolt_rounded),
                  const SizedBox(width: 10),
                  _buildPatternChip('Serverless', Icons.cloud_rounded),
                ],
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _codeController,
              style: const TextStyle(color: Color(0xFF34D399), fontSize: 13, fontFamily: 'monospace'),
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Paste code structure, file tree, or describe your\narchitecture for AI analysis...\n\nsrc/\n  controllers/\n  models/\n  services/',
                hintStyle: TextStyle(color: Colors.grey[700], fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _analyze,
                icon: const Icon(Icons.architecture_rounded),
                label: Text(_isLoading ? '\$ analyzing...' : '\$ analyze-architecture', style: const TextStyle(fontFamily: 'monospace')),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading || _result.isNotEmpty)
              AIResponseCard(response: _result, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternChip(String label, IconData icon) {
    return GlowingCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF34D399), size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
