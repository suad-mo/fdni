import 'package:equatable/equatable.dart';
import 'package:fdni/core/enums/firm.dart';

class BarDataEntitey extends Equatable {
  final Firm _firma;
  final double _total;
  final double _nvo;
  final double _ta;
  final double _usluge;

  const BarDataEntitey({
    required Firm? firma,
    required double? nvo,
    required double? ta,
    required double? usluge,
    required double? total,
  })  : _firma = firma ?? Firm.nullFirm,
        _nvo = nvo ?? 0,
        _ta = ta ?? 0,
        _usluge = usluge ?? 0,
        _total = total ?? 0;

  Firm get firma => _firma;
  double get nvo => _nvo;
  double get ta => _ta;
  double get usluge => _usluge;
  double get total => _total;

  @override
  List<Object?> get props => [
        firma,
        nvo,
        ta,
        usluge,
        total,
      ];
}
