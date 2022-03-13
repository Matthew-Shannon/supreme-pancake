int urlToId(String url) => //
    int.parse(findMatch(url, r'/-?[0-9]+/$') //
        .split('')
        .where((_) => int.tryParse(_) != null || _ == '-')
        .join(''));

String urlToCategory(String url) => //url //
    // .replaceAll(Const.pokeBaseUrl, '')
    // .replaceAll('/', '')
    // .split('')
    // .where((_) => int.tryParse(_) == null || _ != '/')
    // .join('');
    findMatch(url, r'/[a-z\\-]+/-?[0-9]+/$') //
        .split('')
        .where((_) => int.tryParse(_) == null || _ != '/')
        .join('');

// String resUrl(int id, String category) => //
//     '/api/v2/$category/$id/';

String findMatch(String query, String regex) => //
    RegExp(regex).stringMatch(query) ?? '';

String capitalize(String req) => (req.length > 1) //
    ? req[0].toUpperCase() + req.substring(1)
    : req.toUpperCase();

class UnitConvert {
  static String extractFeet(double height) {
    var req = ((height * 3.93701) / 12).truncate();
    return '$req\'';
  }

  static String extractInches(double height) {
    var req = (height * 3.93701).remainder(12).round();
    var pre = req >= 10 ? '' : '0';
    return '$pre$req\"';
  }

  static String extractHeight(double weight) => //
      extractFeet(weight) + extractInches(weight);

  static String extractWeight(double weight) {
    var req = (weight * 0.220462).toStringAsFixed(1);
    return '$req lbs';
  }
}
