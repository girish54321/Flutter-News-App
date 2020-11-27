import 'package:http/http.dart' as http;

class Network {
  var token;

  var mainUrl = "https://newsapi.org/v2/top-headlines?country=in";
  var apiKey = "&apiKey=334f2b6d04f1442ab1d74317b7c5d69e";

  getArticles(category, size) async {
    return await http.get(mainUrl + "&category=$category&page=$size" + apiKey,
        headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization' : 'Bearer $token'
      };
}
