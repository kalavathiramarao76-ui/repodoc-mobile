import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class ApiDocsScreen extends StatefulWidget {
  const ApiDocsScreen({super.key});

  @override
  State<ApiDocsScreen> createState() => _ApiDocsScreenState();
}

class _ApiDocsScreenState extends State<ApiDocsScreen> {
  final _codeController = TextEditingController();
  String _selectedFramework = 'Express.js';
  String _result = '';
  bool _isLoading = false;

  final List<String> _frameworks = ['Express.js', 'FastAPI', 'Spring Boot', 'Go Gin', 'Django', 'Flask', 'NestJS', 'Rails'];

  Future<void> _generate() async {
    if (_codeController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.generateApiDocs(_codeController.text.trim(), _selectedFramework);
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() { _codeController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      appBar: AppBar(title: const Text('API Docs Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TerminalCard(
              title: 'repodoc-api',
              content: '\$ repodoc api --generate\n> Paste API code / routes\n> Select framework\n> OpenAPI-style documentation',
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Framework', icon: Icons.api_rounded),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _frameworks.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final isSelected = _selectedFramework == _frameworks[i];
                  return ChoiceChip(
                    label: Text(_frameworks[i], style: const TextStyle(fontFamily: 'monospace')),
                    selected: isSelected,
                    selectedColor: const Color(0xFF10B981),
                    backgroundColor: const Color(0xFF111A15),
                    labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.w600),
                    side: BorderSide(color: isSelected ? const Color(0xFF10B981) : const Color(0xFF1A2F22)),
                    onSelected: (_) => setState(() => _selectedFramework = _frameworks[i]),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              style: const TextStyle(color: Color(0xFF34D399), fontSize: 13, fontFamily: 'monospace'),
              maxLines: 10,
              decoration: InputDecoration(
                hintText: '// Paste your API routes / controllers here\n\napp.get("/users", (req, res) => {\n  // ...\n});',
                hintStyle: TextStyle(color: Colors.grey[700], fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _generate,
                icon: const Icon(Icons.auto_stories_rounded),
                label: Text(_isLoading ? '\$ generating...' : '\$ generate-api-docs', style: const TextStyle(fontFamily: 'monospace')),
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
}
