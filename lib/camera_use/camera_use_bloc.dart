import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_concept_6/services/theta_service.dart';

part 'camera_use_event.dart';
part 'camera_use_state.dart';

class CameraUseBloc extends Bloc<CameraUseEvent, CameraUseState> {
  CameraUseBloc() : super(CameraUseState.initial()) {
    var chopper = ChopperClient(
        services: [ThetaService.create()], converter: JsonConverter());
    final thetaService = chopper.getService<ThetaService>();
    on<TakePictureEvent>((event, emit) async {
      var response = await thetaService.command({'name': 'camera.takePicture'});
      emit(CameraUseState(message: response.bodyString));
      // TODO: implement event handler
    });
  }
}
