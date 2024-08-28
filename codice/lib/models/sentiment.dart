import 'package:flutter/material.dart';

enum Type { entusiasta, soddisfatto, insoddisfatto, frustrato }

enum Reason { task, collega, fas, mioTeam, altroTeam, altro }

final typeImage = {
  Type.entusiasta: 'assets/emoji/ENTUSIASTA.png',
  Type.soddisfatto: 'assets/emoji/SODDISFATTO.png',
  Type.insoddisfatto: 'assets/emoji/INSODDISFATTO.png',
  Type.frustrato: 'assets/emoji/FRUSTRATO.png',
};

const typeName = {
  Type.entusiasta: 'Entusiasta',
  Type.soddisfatto: 'Soddisfatto',
  Type.insoddisfatto: 'Insoddisfatto',
  Type.frustrato: 'Frustrato',
};

const reasonName = {
  Reason.task: 'Task',
  Reason.collega: 'Collega',
  Reason.fas: 'FAS',
  Reason.mioTeam: 'Il mio team',
  Reason.altroTeam: 'Altro team',
  Reason.altro: 'Altro',
};

const reasonIcons = {
  Reason.task: Icons.task,
  Reason.collega: Icons.people,
  Reason.fas: Icons.supervisor_account_outlined,
  Reason.mioTeam: Icons.groups,
  Reason.altroTeam: Icons.groups_3,
  Reason.altro: Icons.more_horiz,
};

class Sentiment {
  const Sentiment({
    required this.type,
    this.reason,
    this.comment,
    this.date,
  });

  final Type type;
  final Reason? reason;
  final String? comment;
  final DateTime? date;
}
