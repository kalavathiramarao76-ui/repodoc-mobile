import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import '../widgets/app_widgets.dart';

class ChangelogScreen extends StatefulWidget {
  const ChangelogScreen({super.key});

  @override
  State<ChangelogScreen> createState() => _ChangelogScreenState();
}

class _ChangelogScreenState extends State<ChangelogScreen> {
  final _changesController = TextEditingController();
  final _versionController = TextEditingController(text: '1.0.0');
  String _result = '';
  bool _isLoading = false;

  Future<void> _generate() async {
    if (_changesController.text.trim().isEmpty) return;
    setState(() { _isLoading = true; _result = ''; });
    final result = await AIService.generateChangelog(_changesController.text.trim(), _versionController.text.trim());
    if (mounted) setState(() { _result = result; _isLoading = false; });
  }

  @override
  void dispose() { _changesController.dispose(); _versionController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      appBar: AppBar(title: const Text('Changelog Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TerminalCard(
              title: 'repodoc-changelog',
              content: '\$ repodoc changelog --generate\n> List your changes\n> Auto-categorize: Added/Changed/Fixed\n> Keep a Changelog format',
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _versionController,
              style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
              decoration: const InputDecoration(
                hintText: 'Version (e.g., 2.1.0)',
                prefixIcon: Icon(Icons.tag_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _changesController,
              style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: 'List your changes:\n- Added user auth\n- Fixed login bug\n- Updated UI theme\n- Removed deprecated API',
                prefixIcon: Padding(padding: EdgeInsets.only(bottom: 140), child: Icon(Icons.list_rounded)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _generate,
                icon: const Icon(Icons.history_rounded),
                label: Text(_isLoading ? '\$ generating...' : '\$ generate-changelog', style: const TextStyle(fontFamily: 'monospace')),
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading || _result.isNotEmpty)
              AIResponseCard(response: _result, isLoading: _isLoading),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Change Categories', icon: Icons.category_rounded),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: [
                _buildCategoryChip('Added', Colors.greenAccent),
                _buildCategoryChip('Changed', Colors.amberAccent),
                _buildCategoryChip('Deprecated', Colors.orangeAccent),
                _buildCategoryChip('Removed', Colors.redAccent),
                _buildCategoryChip('Fixed', Colors.lightBlueAccent),
                _buildCategoryChip('Security', Colors.purpleAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
    );
  }
}
