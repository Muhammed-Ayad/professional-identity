import 'package:flutter/material.dart';

class CustomizationBrowserFrame extends StatelessWidget {
  final bool isDark;
  final String displayHandle;
  final Widget child;

  const CustomizationBrowserFrame({
    super.key,
    required this.isDark,
    required this.displayHandle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0B0F17) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Browser Window Mockup Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: isDark ? const Color(0xFF1E293B) : Colors.grey.shade200,
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF59E0B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0F172A) : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'https://identity.dev/u/$displayHandle',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
