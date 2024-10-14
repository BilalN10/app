class Dress {
  static List<String> type = ["robes de mariée", "robes cocktail", "robes de soirée", "robes de demoiselles d’honneur", "robes traditionnelles", "robes de bal"];
  static List<String> gender = ['Homme', "Femme", "Autre"];
  static List<String> hairColor = ['blond', 'brun', 'noir', 'gris', 'blanc'];
  static List<String> eyeColor = ['bleu', 'vert', 'marron', 'noir', 'veron'];
}

class DressesService {
  static final List<String> type = [
    'Robes de mariée',
    'Robes cocktail',
    'Robes de soirée',
    'Robes de demoiselles d\'honneur',
    'Robes traditionnelles',
    'Robes de bal'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(type);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
