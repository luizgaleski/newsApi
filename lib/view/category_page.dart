import 'package:flutter/material.dart';
import '../service/newsapi_service.dart';
import 'news_detail_page.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias: ${category[0].toUpperCase() + category.substring(1)}'),
      ),
      body: FutureBuilder(
        future: fetchTopHeadlines(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final data = snapshot.data as Map;
            final articles = data['articles'];

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];

                return ListTile(
                  leading: (article['urlToImage'] != null && article['urlToImage'].isNotEmpty)
                      ? Image.network(
                          article['urlToImage'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50);
                          },
                        )
                      : Icon(Icons.image, size: 50),
                  title: Text(
                    article['title'] ?? 'Sem título',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    article['source']['name'] ?? 'Fonte desconhecida',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(article: article),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
