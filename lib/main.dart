import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_use/camera_use_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraUseBloc(),
      child: MaterialApp(
        home: BlocBuilder<CameraUseBloc, CameraUseState>(
          builder: (context, state) {
            return Scaffold(
              body: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<CameraUseBloc>().add(TakePictureEvent());
                      },
                      icon: Icon(Icons.camera)),
                  Text(state.elaspedTime.toString()),
                  Text(state.cameraState)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
