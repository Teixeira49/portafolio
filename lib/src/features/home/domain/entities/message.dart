import 'package:flutter/material.dart';

class Message {
  final int id;
  final String member;
  final Map<String, dynamic> text;
  final String? contentCode;

  //final DateTime timestamp;

  Message({
    required this.id,
    required this.member,
    required this.text,
    this.contentCode,
    //required this.timestamp,
  });

  @override
  String toString() {
    return 'Message(id: $id, member: $member, content: $text)'; //, timestamp: $timestamp
  }

  String getText(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return text[locale] ?? text['en'] ?? text['es'] ?? '';
  }
}
