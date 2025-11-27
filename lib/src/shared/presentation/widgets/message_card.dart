import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/variables/values/values.dart';

import '../../../core/utils/asset_icons.dart';
import '../../../core/utils/asset_images.dart';
import '../../../core/variables/variables.dart';
import '../../../features/home/domain/entities/message.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message, this.child});

  final Message message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.member == 'You';
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: WidthValues.padding,
          children: [
            if (width >= 480) _MessageCardAvatar(isMe: !isMe, visible: isMe),
            _MessageCardBody(message: message, isMe: isMe, child: child),
            if (width >= 480) _MessageCardAvatar(isMe: !isMe, visible: !isMe),
          ],
        );
      },
    );
  }
}

class _MessageCardBody extends StatelessWidget {
  const _MessageCardBody({
    required this.message,
    required this.isMe,
    this.child,
  });

  final Message message;
  final bool isMe;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Flexible(
    child: Container(
      margin: EdgeInsets.only(bottom: WidthValues.padding),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: WidthValues.padding,
        children: [
          _MessageCardWidget(message: message, isMe: isMe),
          if (child != null) child!,
        ],
      ),
    ),
  );
}

class _MessageCardWidget extends StatelessWidget {
  const _MessageCardWidget({required this.message, required this.isMe});

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(WidthValues.padding),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: isMe ? Radius.circular(WidthValues.radiusMd) : Radius.zero,
        topRight: isMe ? Radius.zero : Radius.circular(WidthValues.radiusMd),
        bottomLeft: Radius.circular(WidthValues.radiusMd),
        bottomRight: Radius.circular(WidthValues.radiusMd),
      ),
      color: isMe ? ColorValues.bgBrandPrimary(context) : Colors.white,
    ),
    child: Column(
      spacing: WidthValues.spacingXs,
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          isMe ? context.l10n.chatYouLabel : message.member,
          textAlign: isMe ? TextAlign.end : TextAlign.start,
          style: ExtendedTextTheme.titleMedium(context),
        ),
        Text(
          message.getText(context),
          textAlign: TextAlign.justify,
          style: ExtendedTextTheme.textSmall(context),
        ),
      ],
    ),
  );
}

class _MessageCardAvatar extends StatelessWidget {
  const _MessageCardAvatar({required this.isMe, required this.visible});

  final bool isMe;
  final bool visible;

  @override
  Widget build(BuildContext context) =>
      visible
          ? SizedBox(width: 40)
          : CircleAvatar(
            backgroundImage: isMe ? AssetImage(AssetImages.profile) : null,
            backgroundColor: ColorValues.bgBrandPrimary(context),
            radius: 20,
            child:
                isMe
                    ? null
                    : SvgPicture.asset(
                      AssetIcons.profile,
                      color: Colors.black87,
                    ),
          );
}
