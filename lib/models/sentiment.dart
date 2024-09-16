import 'package:flutter/material.dart';

enum SType { entusiasta, soddisfatto, insoddisfatto, frustrato }

enum Reason {
  task,
  obiettivi,
  relazioni,
  riconoscimento,
  responsabilita,
  altro
}

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
  Reason.obiettivi: 'Obiettivi',
  Reason.relazioni: 'Relazioni',
  Reason.riconoscimento: 'Riconoscimento',
  Reason.responsabilita: 'Responsabilità',
  Reason.altro: 'Altro',
};

final reasonIcons = {
  Reason.task: Icons.task,
  Reason.obiettivi: Icons.track_changes,
  Reason.relazioni: Icons.groups,
  Reason.riconoscimento: Icons.supervisor_account_outlined,
  Reason.responsabilita: Icons.checklist,
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
