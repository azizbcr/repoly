// Önce bir model oluşturalım
class PolymerFact {
  final String fact;
  final String source;
  final String? sourceUrl;

  PolymerFact({
    required this.fact,
    required this.source,
    this.sourceUrl,
  });
}
