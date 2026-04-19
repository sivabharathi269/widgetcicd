import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  //postsFuture  holds the future result of api call
  late Future<List<dynamic>> _postsFuture;

  @override
  //initstrate() calls only once when the widget is created
  void initState() {
    super.initState();
    //fetchposts create new api response and store in postsfuture
    _fetchPosts();
  }

  void _fetchPosts() {
    setState(() {
      _postsFuture = fetchPosts();
    });
  }

  Future<List<dynamic>> fetchPosts() async {

    await Future.delayed(const Duration(seconds: 1));
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'));

    if (response.statusCode == 200) {
      //if it success then decode the json data
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPosts,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      // FutureBuilder automatically listens to a Future and rebuilds as the state changes
      body: FutureBuilder<List<dynamic>>(
        //holds the api response
        future: _postsFuture,
        //snapshot is  the obj that contains the current state of the future (loading, error, data)
        builder: (context, snapshot) {
          
          // Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Simple loading spinner for beginners
            );
          } 
          
          //  Error State
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text('Failed to load data: ${snapshot.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _fetchPosts,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          } 
          
          //  Empty State
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          //  Success State
          final posts = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  // Navigate to the detail page and pass the data object 'post' as 'extra'
                  onTap: () {
                    context.go('/api/detail', extra: post);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // The Hero widget animates specifically to the next screen!
                        Hero(
                          tag: 'post_icon_${post['id']}',
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            child: Text(post['id'].toString()),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['title'],
                                //theme.of(context) gives the current theme of the app
                                //textTheme is collection of prebuilt textstyles in the ThemeData
                                //this line just get teh current teme and predefined textstyles just add the bold
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                //for the text content it should occupy only one page
                                maxLines: 1,
                                //TextOverflow.ellipsis  it avoids the overflow error by adding ... (dots) if the text is too long
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                post['body'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
