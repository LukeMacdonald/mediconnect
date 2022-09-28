class MessageData{
  final int messageID;
  final int senderID;
  final int receiverID;
  final DateTime timestamp;
  final String message;
  final bool viewed;


  const MessageData(
      this.messageID,
      this.senderID,
      this.receiverID,
      this.timestamp,
      this.message,
      this.viewed);

  factory MessageData.fromJson(dynamic json) {
    return MessageData(
        json['messageID'] as int,
        json['senderID'] as int,
        json['receiverID'] as int,
        json['timestamp'] as DateTime,
        json['message'] as String,
        json['viewed'] as bool);
  }



}