import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/variables/values/values.dart';

import '../../../core/variables/variables.dart';
import '../../../features/home/domain/entities/message.dart';

// Border color for the user bubble: rgba(0, 230, 96, 0.22)
// Alpha: round(0.22 × 255) = 56 = 0x38
const Color _kUserBubbleBorder = Color(0x3800E660);

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message, this.child});

  final Message message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (message.member == 'You') return _UserMessage(message: message);

    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (constraints.maxWidth >= 480) ...[
            _BotAvatar(),
            const Gap(16),
          ],
          Expanded(child: _BotMessageBody(message: message, child: child)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// User bubble  (.msg-user + .ubub)
// ─────────────────────────────────────────────────────────────────────────────

class _UserMessage extends StatelessWidget {
  const _UserMessage({required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      // SizedBox fills the full available width so crossAxisAlignment.end
      // aligns children to the right edge of the parent — not the content edge.
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Identity row: "Tú" + person icon
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.chatYouLabel,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ColorValues.textPrimary(context),
                  ),
                ),
                const Gap(8),
                Icon(
                  Icons.person_outline_rounded,
                  size: 22,
                  color: ColorValues.textTertiary(context),
                ),
              ],
            ),
            const Gap(9),
            // Bubble (.ubub) — max 80 % of parent width
            // border-radius: 20 / 8 / 20 / 20
            //   top-right: 8px  → tail nearest the identity icon
            FractionallySizedBox(
              widthFactor: 0.80,
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: ColorValues.bgGreenTint(context),
                  border: Border.all(color: _kUserBubbleBorder),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  message.getText(context),
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                    color: ColorValues.textPrimary(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bot message  (.msg-bot)
// Plain text messages render without a bubble. Special child widgets
// (skills, projects, experience, etc.) are displayed directly below the text.
// ─────────────────────────────────────────────────────────────────────────────

class _BotMessageBody extends StatelessWidget {
  const _BotMessageBody({required this.message, this.child});

  final Message message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final text = message.getText(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // .bot-name
          Text(
            message.member,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ColorValues.textPrimary(context),
            ),
          ),
          const Gap(10),
          // .bot-text — formatted text with bold, bullets and emojis
          if (text.isNotEmpty)
            _FormattedText(text: text),
          // Special component (skills, projects, timeline, etc.)
          if (child != null) ...[
            if (text.isNotEmpty) const Gap(16),
            child!,
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Formatted text renderer
// Parses a simple inline markup used in chats.json:
//   **text**   → bold span
//   lines that start with "- " → bullet item with a green dot
//   \n\n        → paragraph break (13 px gap)
//   \n          → preserved as a line break inside a paragraph
// All other text is rendered as-is (emojis work natively in Flutter).
// ─────────────────────────────────────────────────────────────────────────────

class _FormattedText extends StatelessWidget {
  const _FormattedText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final paragraphs = text.split('\n\n');
    final widgets = <Widget>[];

    for (int i = 0; i < paragraphs.length; i++) {
      final block = paragraphs[i].trim();
      if (block.isEmpty) continue;

      final lines = block.split('\n');
      final isList = lines.any((l) => l.trim().startsWith('- '));

      if (isList) {
        // Each "- " line → bullet; other lines in the block → plain paragraph
        for (final line in lines) {
          final t = line.trim();
          if (t.startsWith('- ')) {
            widgets.add(_bulletItem(text: t.substring(2).trim(), context: context));
          } else if (t.isNotEmpty) {
            widgets.add(_richParagraph(text: t, context: context));
          }
        }
      } else {
        widgets.add(_richParagraph(text: block, context: context));
      }

      if (i < paragraphs.length - 1) widgets.add(const SizedBox(height: 13));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }
}

// Renders a single bullet item:  ● (green)  text
Widget _bulletItem({required String text, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 10),
          child: Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF00E660),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: _richParagraph(text: text, context: context, dimmed: true)),
      ],
    ),
  );
}

// Renders a paragraph with **bold** inline spans, preserving \n line breaks.
Widget _richParagraph({
  required String text,
  required BuildContext context,
  bool dimmed = false,
}) {
  final base = TextStyle(
    fontSize: 16,
    height: 1.62,
    color: dimmed ? ColorValues.textSecondary(context) : ColorValues.textPrimary(context),
  );

  final spans = <InlineSpan>[];
  final boldRe = RegExp(r'\*\*(.+?)\*\*');
  int cursor = 0;

  for (final m in boldRe.allMatches(text)) {
    if (m.start > cursor) {
      spans.add(TextSpan(text: text.substring(cursor, m.start), style: base));
    }
    spans.add(TextSpan(
      text: m.group(1),
      style: base.copyWith(
        fontWeight: FontWeight.w700,
        color: ColorValues.textPrimary(context),
      ),
    ));
    cursor = m.end;
  }
  if (cursor < text.length) {
    spans.add(TextSpan(text: text.substring(cursor), style: base));
  }

  return Text.rich(TextSpan(children: spans));
}

// ─────────────────────────────────────────────────────────────────────────────
// Bot avatar  (.av-sm)
// Gradient circle with "JT" initials — matches design dark/light variants.
// ─────────────────────────────────────────────────────────────────────────────

class _BotAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF2B2D2E), Color(0xFF1A1C1D)]
              : const [Color(0xFFE9EFEC), Color(0xFFDBE6E1)],
        ),
        border: Border.all(color: ColorValues.borderChip(context)),
      ),
      alignment: Alignment.center,
      child: Text(
        'JT',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: ColorValues.textSecondary(context),
        ),
      ),
    );
  }
}
