// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'camera_use_bloc.dart';

class CameraUseState extends Equatable {
  final String message;
  final String id;
  final String cameraState;
  double elaspedTime = 0.0;
  CameraUseState(
      {required this.message, this.id = "", this.cameraState = "initial"});

  factory CameraUseState.initial() => CameraUseState(message: "initial");

  @override
  List<Object> get props => [message, id, cameraState, elaspedTime];

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
