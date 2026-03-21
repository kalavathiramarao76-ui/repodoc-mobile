import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';
import 'code_documenter_screen.dart';
import 'readme_gen_screen.dart';
import 'api_docs_screen.dart';
import 'architecture_screen.dart';
import 'changelog_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _HomeContent(),
          CodeDocumenterScreen(),
          ReadmeGenScreen(),
          ChangelogScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.code_rounded), label: 'Docs'),
          NavigationDestination(icon: Icon(Icons.description_rounded), label: 'README'),
          NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Changelog'),
          NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('RepoDoc', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, fontFamily: 'monospace')),
                    const SizedBox(height: 4),
                    Text('\$ doc-intelligence', style: TextStyle(color: const Color(0xFF10B981), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'monospace')),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFF111A15), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF1A2F22))),
                  child: const Icon(Icons.terminal_rounded, color: Color(0xFF34D399), size: 28),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Terminal-style status
            TerminalCard(
              title: 'repodoc-status',
              content: '\$ repodoc --status\n> Engine: GPT-OSS 120B\n> Status: Online\n> Docs generated: 12,847\n> Languages: 45+',
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: StatCard(label: 'Docs Generated', value: '12.8K', icon: Icons.article_rounded)),
                const SizedBox(width: 14),
                Expanded(child: StatCard(label: 'Repos Analyzed', value: '3,429', icon: Icons.folder_rounded, color: const Color(0xFF34D399))),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: StatCard(label: 'APIs Documented', value: '8,156', icon: Icons.api_rounded, color: const Color(0xFF6EE7B7))),
                const SizedBox(width: 14),
                Expanded(child: StatCard(label: 'Languages', value: '45+', icon: Icons.code_rounded, color: Colors.tealAccent)),
              ],
            ),

            const SizedBox(height: 28),
            const SectionHeader(title: 'Quick Actions', icon: Icons.flash_on_rounded),
            const SizedBox(height: 8),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.15,
              children: [
                FeatureButton(label: 'Code\nDocumenter', icon: Icons.code_rounded, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CodeDocumenterScreen()))),
                FeatureButton(label: 'README\nGenerator', icon: Icons.description_rounded, color: const Color(0xFF34D399), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReadmeGenScreen()))),
                FeatureButton(label: 'API\nDocs', icon: Icons.api_rounded, color: const Color(0xFF6EE7B7), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ApiDocsScreen()))),
                FeatureButton(label: 'Architecture\nAnalysis', icon: Icons.architecture_rounded, color: Colors.tealAccent, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ArchitectureScreen()))),
              ],
            ),

            const SizedBox(height: 28),
            const SectionHeader(title: 'Recent Projects', icon: Icons.history_rounded),
            ..._buildRecentProjects(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRecentProjects() {
    final projects = [
      {'name': 'react-dashboard', 'lang': 'TypeScript', 'docs': '47 files', 'icon': Icons.web},
      {'name': 'api-gateway', 'lang': 'Go', 'docs': '23 endpoints', 'icon': Icons.cloud},
      {'name': 'ml-pipeline', 'lang': 'Python', 'docs': '31 modules', 'icon': Icons.psychology},
    ];
    return projects.map((p) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlowingCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
              child: Icon(p['icon'] as IconData, color: const Color(0xFF34D399), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'monospace')),
                  const SizedBox(height: 4),
                  Text('${p['lang']} - ${p['docs']}', style: TextStyle(color: Colors.grey[500], fontSize: 13, fontFamily: 'monospace')),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF10B981)),
          ],
        ),
      ),
    )).toList();
  }
}
