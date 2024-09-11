import 'package:flutter/material.dart';

enum SType { entusiasta, soddisfatto, insoddisfatto, frustrato }

enum Reason { task, collega, fas, mioTeam, altroTeam, altro }

final typeImage = {
  SType.entusiasta: 'assets/emoji/ENTUSIASTA.png',
  SType.soddisfatto: 'assets/emoji/SODDISFATTO.png',
  SType.insoddisfatto: 'assets/emoji/INSODDISFATTO.png',
  SType.frustrato: 'assets/emoji/FRUSTRATO.png',
};

final typeName = {
  SType.entusiasta: 'Entusiasta',
  SType.soddisfatto: 'Soddisfatto',
  SType.insoddisfatto: 'Insoddisfatto',
  SType.frustrato: 'Frustrato',
};

final reasonName = {
  Reason.task: 'Task',
  Reason.collega: 'Collega',
  Reason.fas: 'FAS',
  Reason.mioTeam: 'Il mio team',
  Reason.altroTeam: 'Altro team',
  Reason.altro: 'Altro',
};

final reasonIcons = {
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
  });

  final SType type;
  final Reason? reason;
  final String? comment;
}
