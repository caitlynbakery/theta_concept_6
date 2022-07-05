// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'camera_use_bloc.dart';

class CameraUseState extends Equatable {
  final String message;
  final String id;
  final String cameraState;
  double elaspedTime = 0.0;
  final String fileUrl;

  CameraUseState(
      {required this.message,
      this.id = "",
      this.cameraState = "initial",
      this.elaspedTime = 0.0,
      this.fileUrl = ""});

  factory CameraUseState.initial() => CameraUseState(message: "initial");

  @override
  List<Object> get props => [
        message,
        id,
        cameraState,
        elaspedTime,
      ];

  double getElapsedTime() => this.elaspedTime;

  void setElapsedTime(double time) {
    this.elaspedTime = time;
  }

  @override
  bool get stringify => true;

  CameraUseState copyWith({String? message, double? elapsedTime}) {
    return CameraUseState(
      message: message ?? this.message,
      elaspedTime: elaspedTime,
    );
  }
}
