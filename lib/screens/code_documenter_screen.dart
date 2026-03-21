import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class CodeDocumenterScreen extends StatefulWidget {
  const CodeDocumenterScreen({super.key});

  @override
  State<CodeDocumenterScreen> createState() => _CodeDocumenterScreenState();
}

class _CodeDocumenterScreenState extends State<CodeDocumenterScreen> {
  final _codeController = TextEditingController();
  String _selectedLanguage = 'Python';
  String _result = '';
  bool _isLoading = false;

  final List<String> _languages = ['Python', 'JavaScript', 'TypeScript', 'Go', 'Rust', 'Java', 'C++', 'Dart', 'Ruby', 'Swift'];

  Future<void> _document() async {
    if (_codeController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.documentCode(_codeController.text.trim(), _selectedLanguage);
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() { _codeController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      appBar: AppBar(title: const Text('Code Documenter')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TerminalCard(
              title: 'repodoc-documenter',
              content: '\$ repodoc generate --docs\n> Paste your code below\n> Select language\n> Get comprehensive docs',
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Language', icon: Icons.code_rounded),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _languages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final isSelected = _selectedLanguage == _languages[i];
                  return ChoiceChip(
                    label: Text(_languages[i], style: TextStyle(fontFamily: 'monospace')),
                    selected: isSelected,
                    selectedColor: const Color(0xFF10B981),
                    backgroundColor: const Color(0xFF111A15),
                    labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.w600),
                    side: BorderSide(color: isSelected ? const Color(0xFF10B981) : const Color(0xFF1A2F22)),
                    onSelected: (_) => setState(() => _selectedLanguage = _languages[i]),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              style: const TextStyle(color: Color(0xFF34D399), fontSize: 13, fontFamily: 'monospace'),
              maxLines: 12,
              decoration: InputDecoration(
                hintText: '// Paste your code here...\n\nfunction example() {\n  return "documented";\n}',
                hintStyle: TextStyle(color: Colors.grey[700], fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _document,
                icon: const Icon(Icons.auto_fix_high_rounded),
                label: Text(_isLoading ? '\$ generating...' : '\$ generate-docs', style: const TextStyle(fontFamily: 'monospace')),
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
