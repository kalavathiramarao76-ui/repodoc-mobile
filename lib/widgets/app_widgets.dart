import 'package:flutter/material.dart';

class GlowingCard extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const GlowingCard({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFF10B981),
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111A15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: glowColor.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(color: glowColor.withOpacity(0.06), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: child,
    );
  }
}

class TerminalCard extends StatelessWidget {
  final String title;
  final String content;
  final Color accentColor;

  const TerminalCard({
    super.key,
    required this.title,
    required this.content,
    this.accentColor = const Color(0xFF10B981),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F0D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1A2F22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF111A15),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[400])),
                const SizedBox(width: 8),
                Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber[400])),
                const SizedBox(width: 8),
                Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[400])),
                const SizedBox(width: 14),
                Text(title, style: TextStyle(color: Colors.grey[500], fontSize: 13, fontFamily: 'monospace')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              content,
              style: TextStyle(color: accentColor, fontSize: 13, fontFamily: 'monospace', height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color = const Color(0xFF10B981),
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GlowingCard(
      glowColor: color,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 14),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureButton({
    super.key,
    required this.label,
    required this.icon,
    this.color = const Color(0xFF10B981),
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: GlowingCard(
        glowColor: color,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [color.withOpacity(0.2), color.withOpacity(0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }
}

class AIResponseCard extends StatelessWidget {
  final String response;
  final bool isLoading;

  const AIResponseCard({super.key, required this.response, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F0D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1A2F22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF111A15),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[400])),
                const SizedBox(width: 8),
                Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber[400])),
                const SizedBox(width: 8),
                Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[400])),
                const SizedBox(width: 14),
                const Text('repodoc-ai', style: TextStyle(color: Color(0xFF34D399), fontSize: 13, fontFamily: 'monospace', fontWeight: FontWeight.w700)),
                const Spacer(),
                if (isLoading)
                  const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF10B981))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$ generating documentation...', style: TextStyle(color: const Color(0xFF10B981).withOpacity(0.6), fontSize: 13, fontFamily: 'monospace')),
                      const SizedBox(height: 8),
                      ...List.generate(4, (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(height: 14, width: [280.0, 240.0, 260.0, 180.0][i], decoration: BoxDecoration(color: Colors.grey[850], borderRadius: BorderRadius.circular(4))),
                      )),
                    ],
                  )
                : SelectableText(
                    response,
                    style: const TextStyle(color: Color(0xFFA7C4B5), fontSize: 13, fontFamily: 'monospace', height: 1.6),
                  ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.icon, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF10B981), size: 20),
            const SizedBox(width: 8),
          ],
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
