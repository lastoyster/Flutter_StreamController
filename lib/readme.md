Streamcontroller is like a pipe with 
`sink` as input and   `stream` as output /
 To put a new value to the stream, use `streamController.sink.add(newValue)`; to access the output stream use `streamController.stream`.

 In this demo, the card renders the widget from _outputStreamController.stream and you can send a new random word to the _inputStreamController.sink by clicking send button.