// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theta_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ThetaService extends ThetaService {
  _$ThetaService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ThetaService;

  @override
  Future<Response<dynamic>> command(Map<String, dynamic> body) {
    final $url = 'http://192.168.1.1/osc/commands/execute';
    final $headers = {
      'Content-Type': 'application/json;charset=utf-8',
    };

    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> info() {
    final $url = 'http://192.168.1.1/osc/info';
    final $headers = {
      'Content-Type': 'application/json;charset=utf-8',
    };

    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
