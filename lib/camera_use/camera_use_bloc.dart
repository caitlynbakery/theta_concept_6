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
    Stopwatch stopwatch = Stopwatch();

    on<TakePictureEvent>((event, emit) async {
      stopwatch.start();
      var response = await thetaService.command({'name': 'camera.takePicture'});
      var convertResponse = jsonDecode(response.bodyString);
      var id = convertResponse['id'];

      if (convertResponse != null && id != null) {
        emit(CameraUseState(message: response.bodyString, id: id));

        while (state.cameraState != "done") {
          add(CameraStatusEvent());

          await Future.delayed(Duration(milliseconds: 200));
          print(state.cameraState);
          print(state.elaspedTime);
          emit(CameraUseState(
              id: id,
              message: response.bodyString,
              elaspedTime: stopwatch.elapsedMilliseconds.toDouble(),
              cameraState: state.cameraState));
          // emit(state.copyWith(elapsedTime:));
          //     state.elaspedTime = stopwatch.elapsedMilliseconds.toDouble();
        }
        stopwatch.stop();
        // emit(CameraUseState(
        //       id: id,
        //       message: response.bodyString,
        //       elaspedTime: stopwatch.elapsedMilliseconds.toDouble(),
        //       cameraState: state.cameraState));
        stopwatch.reset();
        add(ImagePictureEvent());
      }
    });
    on<CameraStatusEvent>((event, emit) async {
      if (state.id.isNotEmpty) {
        var response = await thetaService.status({'id': state.id});
        var convertResponse = jsonDecode(response.bodyString);
        var cameraState = convertResponse['state'];

        emit(CameraUseState(
            message: response.bodyString,
            id: state.id,
            cameraState: cameraState,
            elaspedTime: stopwatch.elapsedMilliseconds.toDouble()));
      }
    });
    on<ImagePictureEvent>((event, emit) async {
      var response = await thetaService.command({
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 1,
          'maxThumbSize': 0
        }
      });
      var convertResponse = jsonDecode(response.bodyString);
      var fileUrl = convertResponse['results']['entries'][0]['fileUrl'];
      emit(CameraUseState(
          message: '',
          fileUrl: fileUrl,
          cameraState: state.cameraState,
          elaspedTime: state.elaspedTime));
      print(fileUrl);
    });
  }
}
