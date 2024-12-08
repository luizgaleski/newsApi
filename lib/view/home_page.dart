import 'package:flutter/material.dart';
import 'category_page.dart';
import 'search_results_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'business', 'displayName': 'Negócios', 'description': 'Notícias sobre negócios e economia.', 'emoji': '💼'},
    {'name': 'entertainment', 'displayName': 'Entretenimento', 'description': 'Fique por dentro do mundo do entretenimento.', 'emoji': '🎥'},
    {'name': 'general', 'displayName': 'Geral', 'description': 'Notícias gerais do mundo todo.', 'emoji': '🌍'},
    {'name': 'health', 'displayName': 'Saúde', 'description': 'Tudo sobre saúde e bem-estar.', 'emoji': '🩺'},
    {'name': 'science', 'displayName': 'Ciência', 'description': 'Descubra novidades sobre ciência.', 'emoji': '🔬'},
    {'name': 'sports', 'displayName': 'Esportes', 'description': 'Acompanhe os últimos esportes.', 'emoji': '⚽️'},
    {'name': 'technology', 'displayName': 'Tecnologia', 'description': 'Inovações e tendências em tecnologia.', 'emoji': '💻'},
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    void _search() {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultsPage(query: query),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, digite algo para pesquisar.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('UniNews'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Pesquisar notícias',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: _search,
              ),
            ),
            onSubmitted: (_) => _search(),
          ),
          SizedBox(height: 24),

          ...categories.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 16.0), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(category: category['name']!),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${category['emoji']} ', 
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        category['displayName']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  category['description']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 24),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
