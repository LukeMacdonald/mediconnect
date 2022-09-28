class MessageData{
  final int senderID;
  final int receiverID;
  final DateTime timestamp;
  final String message;
  final bool viewed;


  const MessageData(
      this.senderID,
      this.receiverID,
      this.timestamp,
      this.message,
      this.viewed);

  factory MessageData.fromJson(dynamic json) {
    return MessageData(
        json['sender'] as int,
        json['receiver'] as int,
        json['timestamp'] as DateTime,
        json['message'] as String,
        json['viewed'] as bool);
  }



}