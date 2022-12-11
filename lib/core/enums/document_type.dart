enum DocumentType {
  plan(id: 0, name: 'Plan', translation: 'Plan'),
  raport(id: 1, name: 'Report', translation: 'Izvještaj'),
  nullDocumentType(
      id: -1, name: 'Null Document Type', translation: 'Null Document Type');

  final int id;
  final String name;
  final String translation;

  const DocumentType({
    required this.id,
    required this.name,
    required this.translation,
  });

  static DocumentType getWithId(int? id) => DocumentType.values.firstWhere(
        (el) => el.id == id,
        orElse: () => DocumentType.nullDocumentType,
      );
}
