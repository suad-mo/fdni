enum Firms {
  igman(id: 1, name: 'IGMAN d.d. Konjic', shortName: 'IGMAN'),
  ginex(id: 2, name: 'UNIS- GINEX d.d. Goražde', shortName: 'GINEX'),
  trz(id: 3, name: 'TRZ Hadžići d.d.', shortName: 'TRZ'),
  pretis(id: 4, name: 'PRETIS d.d. Vogošća', shortName: 'PRETIS'),
  zrak(id: 5, name: 'ZRAK d.d. Sarajevo', shortName: 'ZRAK'),
  bnt(id: 6, name: 'BNT-TMiH d.d. Novi Travnik', shortName: 'BNT'),
  binas(id: 7, name: 'Binas d.d. Bugojno', shortName: 'BINAS'),
  vitezit(id: 8, name: 'PS Vitezit d.o.o. Vitez', shortName: 'VITEZIT'),
  rudet(id: 9, name: 'POBJEDA-Rudet d.d. Goražde', shortName: 'RUDET'),
  tehnology(
      id: 10, name: 'POBJEDA-Tehnology d.d. Goražde', shortName: 'TEHNOLOGY'),
  koteks(id: 11, name: 'KOTEKS d.o.o. Tešanj', shortName: 'KOTEKS'),
  guma(id: 12, name: 'GUMA-CO d.o.o. Bugojno', shortName: 'GUMA'),
  acUnity(id: 13, name: 'AC-Unity d.o.o. Goražde', shortName: 'ACUnity'),
  omc(id: 14, name: 'OMC d.o.o. Vogošća', shortName: 'OMC'),
  bntHolding(
      id: 15, name: 'BNT Holding d.d. Novi Travnik', shortName: 'BNTHolding'),
  danialS(id: 16, name: 'DANIAL S d.o.o. Tešanj', shortName: 'DANIAL-S'),
  nullFirm(id: -1, name: 'No name', shortName: 'No name'),
  ;

  const Firms({
    required this.id,
    required this.name,
    required this.shortName,
  });
  final int id;
  final String name;
  final String shortName;

  static Firms getWithId(int? id) => Firms.values.firstWhere(
        (el) => el.id == id,
        orElse: () => Firms.nullFirm,
      );
}
