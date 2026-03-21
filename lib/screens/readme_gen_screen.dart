import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class ReadmeGenScreen extends StatefulWidget {
  const ReadmeGenScreen({super.key});

  @override
  State<ReadmeGenScreen> createState() => _ReadmeGenScreenState();
}

class _ReadmeGenScreenState extends State<ReadmeGenScreen> {
  final _projectController = TextEditingController();
  final _descController = TextEditingController();
  String _result = '';
  bool _isLoading = false;

  Future<void> _generate() async {
    if (_projectController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.generateReadme(_projectController.text.trim(), _descController.text.trim());
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() { _projectController.dispose(); _descController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      appBar: AppBar(title: const Text('README Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TerminalCard(
              title: 'repodoc-readme',
              content: '\$ repodoc readme --generate\n> Project name + description\n> Professional README.md output',
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _projectController,
              style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
              decoration: const InputDecoration(
                hintText: 'Project name (e.g., awesome-api)',
                prefixIcon: Icon(Icons.folder_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _descController,
              style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Project description, tech stack, features...',
                prefixIcon: Padding(padding: EdgeInsets.only(bottom: 80), child: Icon(Icons.info_outline_rounded)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _generate,
                icon: const Icon(Icons.description_rounded),
                label: Text(_isLoading ? '\$ generating...' : '\$ generate-readme', style: const TextStyle(fontFamily: 'monospace')),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading || _result.isNotEmpty)
              AIResponseCard(response: _result, isLoading: _isLoading),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Templates', icon: Icons.bookmark_rounded),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: ['CLI Tool', 'REST API', 'React App', 'Python Library', 'Mobile App', 'ML Model'].map((tag) {
                return ActionChip(
                  label: Text(tag, style: const TextStyle(fontFamily: 'monospace')),
                  labelStyle: const TextStyle(color: Color(0xFF10B981), fontSize: 13),
                  backgroundColor: const Color(0xFF111A15),
                  side: const BorderSide(color: Color(0xFF1A2F22)),
                  onPressed: () {
                    _projectController.text = tag.toLowerCase().replaceAll(' ', '-');
                    _descController.text = 'A $tag project with modern architecture and best practices.';
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
