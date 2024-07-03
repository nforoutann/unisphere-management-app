import 'dart:convert';
import 'dart:typed_data';

class Task {
  String title;
  bool done;

  Task({required this.title, required this.done});

  static Task deserialize(ByteData buffer, int offset) {
    int titleLength = buffer.getUint16(offset, Endian.big);
    offset += 2;
    String title = utf8.decode(buffer.buffer.asUint8List(offset, titleLength));
    offset += titleLength;
    bool done = buffer.getInt8(offset) != 0;
    offset += 1;
    return Task(title: title, done: done);
  }
}