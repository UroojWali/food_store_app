extension ShortString on String {
  String toShortString(int numberOfCharacters) {
    String shortName = "";
    shortName = split(' ').map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase();
    }).join();
    shortName = shortName.substring(
      0,
      shortName.length > numberOfCharacters
          ? numberOfCharacters
          : shortName.length,
    );
    return shortName;
  }
}
