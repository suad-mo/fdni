part of 'firm_bloc.dart';

abstract class FirmState extends Equatable {
  const FirmState();

  @override
  List<Object> get props => [];
}

class FirmInitialState extends FirmState {}

class FirmLoadingState extends FirmState {}

class FirmLoadedState extends FirmState {
  final List<FirmEntity> firms;

  const FirmLoadedState({required this.firms});
}

class FirmRetrievalErrorState extends FirmState {
  final String _message;

  const FirmRetrievalErrorState({required String message}) : _message = message;

  String get message => _message;
}
