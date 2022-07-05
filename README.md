# THETA X Concept 6

After running a takePicture command, a developer must check to see if the camera is ready before issuing another command

## Overview

The camera will take 3-5 seconds after a picture is taken to be ready to take another picture.  The time may vary depending on light conditions and filters.  For example, using the HDR filter will result in a longer time to be ready.  There are many scenarios where the time to execute a command will vary.  This tutorial focuses on taking a picture and then using [commands/status](https://api.ricoh/docs/theta-web-api-v2.1/protocols/commands_status/) to see if the "taking picture" process is "done".

## Steps
* take picture with commands/execute
* get command "id" of commands/execute https://api.ricoh/docs/theta-web-api-v2.1/protocols/commands_execute/

![image](https://user-images.githubusercontent.com/5799860/176561306-21da5cbd-a078-4466-af66-2e0afce837f3.png)

* using commands/status and the "id", get the "state" of the camera, either "inProgress" or "done"
* The `/commands/status` command needs to be in a loop with a delay between calls to `/commands/status`.  One way to add a delay in Dart is to use `Future.delayed()` - example    `Future.delayed(Duration(milliseconds: 200))`
* set up timer in Dart and start the timer when the takePicture command is run.  one possibility is to use Stopwatch class in Dart. https://api.dart.dev/be/177591/dart-core/Stopwatch-class.html (recommended, but not required)
* display the elapsed time from the point the takePicture button is pressed until the camera is ready. 
* when the camera is ready, show camera ready
* leave elapsed time on the screen for reference.  Use at least a tenth of a second accuracy

### Optional

* once the camera shows a "state" of "done," display the image as a thumbnail

### Optional Part 2

* when the camera is inProgress, show a CircularProgressIndicator or similar spinner in addition to the time
  * optional portion of pt 2.  Assess flutter_spinkit for possible use https://pub.dev/packages/flutter_spinkit  or Flutter EasyLoading https://pub.dev/packages/flutter_easyloading

### optional part 3

Test different delays between `/osc/status` command.  Likely the delay will be around 100ms to 300ms

## Learning Points to Include in README

* application must check "camera status" to see if camera is ready for the next command.  If the camera status is not checked, THETA apps may exhibit unexpected behavior
* using `/osc/status` is a little difficult since the API command requires the "id" of the previous command it is checking on.  The developer needs to chain two commands together
* the check for `/osc/status` needs to be in a loop.  The developer needs to delay the iteration of the loop so that the camera CPU is not overloaded

## Problems Encountered

* Add properties to the `prop` list in state in order for the state to update

```dart
  List<Object> get props => [message, id, cameraState];
```

* Add `id` when emitting the `CameraStatusEvent` 

```dart
emit(CameraUseState(
            message: response.bodyString,
            id: state.id,
            cameraState: cameraState));
```

* Although the application can update the UI with a stopwatch, the code to run the program gets quite long. The state is emitted multiple times in order to update the stopwatch. 
