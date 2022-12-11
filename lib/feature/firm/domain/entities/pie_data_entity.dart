import 'package:equatable/equatable.dart';

class PieDataEntitey extends Equatable {
  final String _firma;
  final double _total;

  const PieDataEntitey({
    required String? firma,
    required double? total,
  })  : _firma = firma ?? 'No name',
        _total = total ?? 0;

  String get firma => _firma;

  double get total => _total;

  @override
  List<Object?> get props => [firma, total];
}
