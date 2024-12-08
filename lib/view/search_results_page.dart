import 'package:flutter/material.dart';
import '../service/newsapi_service.dart';
import 'news_detail_page.dart';

class SearchResultsPage extends StatelessWidget {
  final String query;

  SearchResultsPage({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados para "$query"'),
      ),
      body: FutureBuilder(
        future: searchNews(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar notícias'));
          } else {
            final data = snapshot.data as Map;
            final articles = data['articles'];

            if (articles.isEmpty) {
              return Center(
                child: Text(
                  'Não existem notícias relacionadas a essa palavra',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              );
            }

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
                      : Icon(Icons.image, size: 50), // Ícone para notícias sem imagem
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
