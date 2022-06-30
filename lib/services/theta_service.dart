import 'package:chopper/chopper.dart';

part 'theta_service.chopper.dart';

@ChopperApi(baseUrl: 'http://192.168.1.1/osc')
abstract class ThetaService extends ChopperService {
  @Post(
      path: '/commands/execute',
      headers: {'Content-Type': 'application/json;charset=utf-8'})
  Future<Response> command(@Body() Map<String, dynamic> body);
  @Get(
      path: '/info',
      headers: {'Content-Type': 'application/json;charset=utf-8'})
  Future<Response> info();
  static ThetaService create() {
    return _$ThetaService();
  }
}
