import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final Map article;

  NewsDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title'] ?? 'Detalhes da Notícia'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(
                article['urlToImage'],
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, size: 100);
                },
              ),
            SizedBox(height: 16),
            Text(
              article['title'] ?? 'Sem título',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Fonte: ${article['source']['name'] ?? 'Desconhecida'}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Publicado em: ${DateTime.parse(article['publishedAt']).toLocal()}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              article['description'] ?? 'Sem descrição disponível',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
