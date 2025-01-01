class Polymer {
  final String name;
  final String abbreviation;
  final double meltingTemp; // Tm
  final double glassTransitionTemp; // Tg
  final double meltFlowIndex; // MFI
  final String description;
  final Map<String, String> additionalProperties;
  bool isFavorite; // Yeni eklenen özellik

  Polymer({
    required this.name,
    required this.abbreviation,
    required this.meltingTemp,
    required this.glassTransitionTemp,
    required this.meltFlowIndex,
    required this.description,
    required this.additionalProperties,
    this.isFavorite = false, // Varsayılan değer
  });
}
