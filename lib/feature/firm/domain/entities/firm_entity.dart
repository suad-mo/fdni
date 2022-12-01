import 'package:equatable/equatable.dart';

class FirmEntity extends Equatable {
  const FirmEntity({
    required this.idFirm,
    required this.name,
  });

  final int idFirm;
  final String name;

  @override
  List<Object?> get props => [idFirm, name];
}
