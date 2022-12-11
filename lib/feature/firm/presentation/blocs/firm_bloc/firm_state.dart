part of 'firm_bloc.dart';

abstract class FirmState extends Equatable {
  final List<FirmEntity> firms;
  const FirmState({this.firms = const <FirmEntity>[]});

  @override
  List<Object> get props => [firms];
}

class FirmInitialState extends FirmState {}

class FirmLoadingState extends FirmState {}

class FirmLoadedState extends FirmState {
  final List<FirmSelected> selectFirms;

  const FirmLoadedState({required this.selectFirms, super.firms});

  List<FirmSelected> get onlySelectedFirm =>
      selectFirms.where((firm) => firm.selected).toList();

  List<FirmSelected> get onlyUnselectedFirm =>
      selectFirms.where((firm) => !firm.selected).toList();

  @override
  List<Object> get props => [super.firms, selectFirms];
}

class FirmChangeSelectedFirmsState extends FirmState {
  final List<FirmSelected> selectFirms;

  const FirmChangeSelectedFirmsState({
    required this.selectFirms,
    required int id,
  }) : super(firms: selectFirms);

  @override
  List<Object> get props => [selectFirms];
}

class FirmRetrievalErrorState extends FirmState {
  final String _message;

  const FirmRetrievalErrorState({required String message, super.firms})
      : _message = message;

  String get message => _message;
}
