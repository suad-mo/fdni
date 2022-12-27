enum DocumentSubType {
  annual(
    id: 0,
    name: 'Annual',
    translation: 'Godišnji',
    translationII: 'Godina',
  ),
  quarter1(
    id: 1,
    name: '1. Quarter',
    translation: '1. Kvartal',
    translationII: 'I Kvartal',
  ),
  quarter2(
    id: 2,
    name: '2. Quarter',
    translation: '2. Kvartal',
    translationII: 'II Kvartal',
  ),
  quarter3(
    id: 3,
    name: '3. Quarter',
    translation: '3. Kvartal',
    translationII: 'III Kvartal',
  ),
  quarter4(
    id: 4,
    name: '4. Quarter',
    translation: '4. Kvartal',
    translationII: 'IV Kvartal',
  ),
  nullDocumentSubType(
    id: -1,
    name: 'Null',
    translation: 'Null',
    translationII: 'Null',
  );

  final int id;
  final String name;
  final String translation;
  final String translationII;

  const DocumentSubType({
    required this.id,
    required this.name,
    required this.translation,
    required this.translationII,
  });

  static DocumentSubType getWithId(int? id) =>
      DocumentSubType.values.firstWhere(
        (el) => el.id == id,
        orElse: () => DocumentSubType.nullDocumentSubType,
      );
}
