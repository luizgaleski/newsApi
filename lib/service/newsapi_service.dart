import 'package:http/http.dart' as http;
import 'dart:convert';

const String _apiKey = "7e019e39c6804de4aa0f2f647d30a526";

Future<Map> fetchTopHeadlines(String category) async {
  http.Response response;
  response = await http.get(Uri.parse(
      "https://newsapi.org/v2/top-headlines?apiKey=$_apiKey&category=$category"));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Erro ao carregar as notícias por categoria");
  }
}

Future<Map> searchNews(String query) async {
  http.Response response;
  response = await http.get(Uri.parse(
      "https://newsapi.org/v2/everything?q=$query&apiKey=$_apiKey"));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Erro ao carregar as notícias por palavras-chave");
  }
}
