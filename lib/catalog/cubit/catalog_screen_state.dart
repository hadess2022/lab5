abstract class CatalogScreenState {
  const CatalogScreenState();
}

class CatalogScreenUpdateState extends CatalogScreenState {
  final String category;
  final Map<String, dynamic> films;
  final List<String> posters;

  
  const CatalogScreenUpdateState({ required this.category, required this.films , required this.posters });
}