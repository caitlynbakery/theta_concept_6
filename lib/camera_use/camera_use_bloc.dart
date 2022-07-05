import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_concept_6/services/theta_service.dart';

part 'camera_use_event.dart';
part 'camera_use_state.dart';

class CameraUseBloc extends Bloc<CameraUseEvent, CameraUseState> {
  CameraUseBloc() : super(CameraUseState.initial()) {
    var chopper = ChopperClient(
        services: [ThetaService.create()], converter: const JsonConverter());
    final thetaService = chopper.getService<ThetaService>();
    on<TakePictureEvent>((event, emit) async {
      var response = await thetaService.command({'name': 'camera.takePicture'});
      var convertResponse = jsonDecode(response.bodyString);
      var id = convertResponse['id'];
      emit(CameraUseState(message: response.bodyString, id: id));

      while (state.cameraState != "done") {
        add(CameraStatusEvent());

        await Future.delayed(Duration(milliseconds: 200));
        print(state.cameraState);
      }
      print(state.cameraState);
    });
    on<CameraStatusEvent>((event, emit) async {
      if (state.id.isNotEmpty) {
        var response = await thetaService.status({'id': state.id});
        var convertResponse = jsonDecode(response.bodyString);
        var cameraState = convertResponse['state'];

        emit(CameraUseState(
            message: response.bodyString,
            id: state.id,
            cameraState: cameraState));
//TODO: cameraState is not updating to inProgress
        //  print(state.cameraState);
      }
    });
  }
}
