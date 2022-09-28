// import 'dart:async';
//
// import 'package:nd_telemedicine/models/message_data.dart';
// import 'package:rethink_db_ns/rethink_db_ns.dart';
//
// import '../models/user.dart';
//
// class MessageService{
//   final Connection _connection;
//   final RethinkDb r;
//
//   MessageService(this.r,this._connection);
//
//   final _controller = StreamController<MessageData>.broadcast();
//
//   Future<bool> send(MessageData message){
//     throw UnimplementedError();
//   }
//   Stream<MessageData> messages({required User active}){
//     Map record = await
//     throw UnimplementedError();
//   }
//   dispose(){
//     _controller.close();
//
//   }
// }