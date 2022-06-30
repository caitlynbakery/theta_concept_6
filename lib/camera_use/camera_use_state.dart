// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'camera_use_bloc.dart';

class CameraUseState extends Equatable {
  final String message;
  const CameraUseState({
    required this.message,
  });

  factory CameraUseState.initial() => CameraUseState(message: "initial");

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  CameraUseState copyWith({
    String? message,
  }) {
    return CameraUseState(
      message: message ?? this.message,
    );
  }
}
