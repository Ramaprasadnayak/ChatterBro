import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId, senderEmail, receiverId, message;
  final Timestamp timestamp;

  Message({required this.senderId, required this.senderEmail, required this.receiverId, required this.message, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      receiverId: map['receiverId'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }
}