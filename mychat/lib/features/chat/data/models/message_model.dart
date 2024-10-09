//message model class
class MessageModel {
  final int id;
  final String message;
  final String time;
  final String type;

  MessageModel({
    required this.id,
    required this.message,
    required this.time,
    required this.type,
  });
}
