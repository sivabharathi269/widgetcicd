import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'What is WidgetHub?',
      'answer':
          'WidgetHub is a productivity and learning dashboard that demonstrates various Flutter widgets in an adaptive, cross-platform layout.',
    },
    {
      'question': 'Which platforms does it support?',
      'answer':
          'WidgetHub is designed to be fully responsive and works seamlessly across Mobile, Tablet, Web, and Desktop environments.',
    },
    {
      'question': 'How does the Task Manager work?',
      'answer':
          'The Task Manager uses an AnimatedList for smooth UI updates, riverpod for state management, and SharedPreferences for local persistence. You can swipe left to delete or swipe right to complete tasks.',
    },
    {
      'question': 'Can I toggle Dark Mode?',
      'answer':
          'Yes! Visit the Settings page to toggle between light and dark themes using a custom animated switch.',
    },
    {
      'question': 'How is routing handled?',
      'answer':
          'Routing uses GoRouter to manage paths and handle deep links effectively across all platforms.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final faq = _faqs[index];
          final isExpanded = _expandedIndex == index;

          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              title: Text(
                faq['question']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              initiallyExpanded: isExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  if (expanded) {
                    _expandedIndex = index;
                  } else {
                    if (_expandedIndex == index) {
                      _expandedIndex = null;
                    }
                  }
                });
              },
              children: [
                Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faq['answer']!,
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
