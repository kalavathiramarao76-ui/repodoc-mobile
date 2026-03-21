import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _autoFormat = true;
  bool _darkMode = true;
  bool _syntaxHighlight = true;
  String _defaultLanguage = 'Python';
  String _docStyle = 'Detailed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlowingCard(
              child: Row(
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFF10B981), Color(0xFF065F46)])),
                    child: const Icon(Icons.terminal_rounded, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('RepoDoc User', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                        const SizedBox(height: 4),
                        Text('Developer Pro', style: TextStyle(color: const Color(0xFF10B981), fontSize: 14, fontFamily: 'monospace')),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: Color(0xFF10B981)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const SectionHeader(title: 'Documentation', icon: Icons.article_rounded),
            _buildDropdown('Default Language', Icons.code_rounded, _defaultLanguage, ['Python', 'JavaScript', 'TypeScript', 'Go', 'Rust', 'Java'], (v) => setState(() => _defaultLanguage = v!)),
            _buildDropdown('Doc Style', Icons.style_rounded, _docStyle, ['Minimal', 'Standard', 'Detailed', 'Comprehensive'], (v) => setState(() => _docStyle = v!)),
            _buildToggle('Auto-Format Output', Icons.auto_fix_high_rounded, _autoFormat, (v) => setState(() => _autoFormat = v)),
            _buildToggle('Syntax Highlighting', Icons.highlight_rounded, _syntaxHighlight, (v) => setState(() => _syntaxHighlight = v)),

            const SizedBox(height: 20),
            const SectionHeader(title: 'App Settings', icon: Icons.settings_rounded),
            _buildToggle('Push Notifications', Icons.notifications_active_rounded, _pushNotifications, (v) => setState(() => _pushNotifications = v)),
            _buildToggle('Dark Mode', Icons.dark_mode_rounded, _darkMode, (v) => setState(() => _darkMode = v)),

            const SizedBox(height: 20),
            const SectionHeader(title: 'About', icon: Icons.info_rounded),
            _buildInfoTile('App Version', '1.0.0', Icons.verified_rounded),
            _buildInfoTile('AI Engine', 'GPT-OSS 120B', Icons.auto_awesome_rounded),
            _buildInfoTile('API Endpoint', 'sai.sharedllm.com', Icons.cloud_rounded),

            const SizedBox(height: 30),
            TerminalCard(
              title: 'repodoc-info',
              content: '\$ repodoc --version\nRepoDoc v1.0.0\nPowered by SharedLLM\n(c) 2025 RepoDoc',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(String title, IconData icon, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlowingCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF10B981), size: 22),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'monospace'))),
            Switch(value: value, onChanged: onChanged, activeColor: const Color(0xFF10B981)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String title, IconData icon, String value, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlowingCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF10B981), size: 22),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'monospace'))),
            DropdownButton<String>(
              value: value, dropdownColor: const Color(0xFF111A15),
              style: const TextStyle(color: Color(0xFF10B981), fontFamily: 'monospace'), underline: const SizedBox(),
              items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlowingCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF10B981), size: 22),
            const SizedBox(width: 14),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'monospace')),
            const Spacer(),
            Text(value, style: TextStyle(color: Colors.grey[500], fontSize: 14, fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }
}
