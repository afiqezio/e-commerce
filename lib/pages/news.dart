import 'package:flutter/material.dart';

import '../custom_appbar.dart';

class NewsScreen extends StatelessWidget {
  final List<Map<String, String>> dummyNews = [
    {
      'title': 'Churros Festival 2024',
      'content': 'Join us for the biggest churros festival in town, featuring delicious churros from around the world!',
      'date': 'Nov 25, 2024',
    },
    {
      'title': 'New Churros Flavors Released!',
      'content': 'Introducing matcha, blueberry, and caramel churros—perfect for your taste buds.',
      'date': 'Nov 20, 2024',
    },
    {
      'title': 'Churros Delight Partners with Local Farms',
      'content': 'We’re proud to announce a partnership to use 100% locally sourced ingredients.',
      'date': 'Nov 15, 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'News'),
      body: ListView.builder(
        itemCount: dummyNews.length,
        itemBuilder: (context, index) {
          final news = dummyNews[index];
          return Card(
            margin: EdgeInsets.all(12),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news['title']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(news['content']!),
                  SizedBox(height: 12),
                  Text(
                    news['date']!,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
