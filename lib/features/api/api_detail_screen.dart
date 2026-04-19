import 'package:flutter/material.dart';

class ApiDetailScreen extends StatelessWidget {
  //post is the api data
  final Map<String, dynamic> post;

  const ApiDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail View'),
      ),
      //singlechildscrollview is allows to scroll the widgets vertically
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Hero(
              tag: 'post_icon_${post['id']}',
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  post['id'].toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              post['title'],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                post['body'],
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
