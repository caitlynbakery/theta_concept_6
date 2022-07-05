import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_concept_6/full_image_screen.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<CameraUseBloc>()
                                .add(TakePictureEvent());
                          },
                          iconSize: 100,
                          icon: Icon(Icons.camera)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${state.elaspedTime}',
                        //'Timer: ${(state.elaspedTime / 1000).toString()}',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('State: ${state.cameraState}',
                          style: TextStyle(fontSize: 30)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.cameraState == 'done' && state.fileUrl.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullImageScreen(
                                            fileUrl: state.fileUrl)));
                              },
                              child:
                                  Image.network('${state.fileUrl}?type=thumb'))
                          : Container()
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
