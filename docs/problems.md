# Problems Encountered

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