import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:portafolio/src/core/theme/extended_text_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/asset_images.dart';
import '../../../core/variables/values/values.dart';
import '../../../features/home/presentation/bloc/chat_bloc/bloc.dart';

class ResumeBody extends StatelessWidget {
  const ResumeBody({super.key, required this.aboutData});

  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final children = [
      _ResumeTitle(aboutData: aboutData),
      _DynamicDivider(width: width),
      _ResumeData(aboutData: aboutData),
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WidthValues.radiusMd),
        color: ColorValues.bgSecondary(context),
      ),
      padding: EdgeInsets.all(WidthValues.padding),
      child:
          width > 1100
              ? Row(
                spacing: WidthValues.spacingMd,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: children,
              )
              : Column(
                spacing: WidthValues.spacingMd,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
    );
  }
}

class _ResumeTitle extends StatelessWidget {
  const _ResumeTitle({required this.aboutData});

  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final avatar = CircleAvatar(
        backgroundImage: AssetImage(AssetImages.profile),
        radius: 40,
      );
      final children = [
        if (width > 315) avatar,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              aboutData["name"].toString(),
              style: ExtendedTextTheme.titleMedium(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            Text(
              context.l10n.resumeTitleLabel,
              style: ExtendedTextTheme.textMedium(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Divider(height: 2),
            _LocationRow(
              location: aboutData["location"].toString(),
              link: aboutData["location_link"].toString(),
            ),
          ],
        ),
      ];
      return width > 315
          ? Row(
            spacing: WidthValues.spacingMd,
            mainAxisSize: MainAxisSize.min,
            children: children,
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: WidthValues.spacingXs,
            children: [
              avatar,
              Row(
                spacing: WidthValues.spacingMd,
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ],
          );
    },
  );
}

class _ResumeData extends StatelessWidget {
  const _ResumeData({required this.aboutData});

  final Map<String, dynamic> aboutData;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    textBaseline: TextBaseline.alphabetic,
    verticalDirection: VerticalDirection.down,
    spacing: WidthValues.spacingXs,
    children: [
      _SubContainer(
        data: aboutData["years"].toString(),
        title: context.l10n.resumeYearsCompleteLabel,
        function:
            () => context.read<ChatBloc>().add(GetChatMessages('experience_chat')),
      ),
      _SubContainer(
        data: aboutData["projects"].toString(),
        title: context.l10n.resumeProjectsCompleteLabel,
        function:
            () => context.read<ChatBloc>().add(GetChatMessages('projects_chat')),
      ),
    ],
  );
}

class _DynamicDivider extends StatelessWidget {
  final double width;

  const _DynamicDivider({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width > 1100 ? 2.5 : width,
      height: width > 1100 ? 80 : 2.5,
      color: ColorValues.fgBrandPrimary(context),
    );
  }
}

class _LocationRow extends StatefulWidget {
  const _LocationRow({required this.location, required this.link});

  final String location;
  final String link;

  @override
  State<_LocationRow> createState() => _LocationRowState();
}

class _LocationRowState extends State<_LocationRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _isHovered = true),
    onExit: (_) => setState(() => _isHovered = false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () => launchUrl(Uri.parse(widget.link)),
      child: Row(
        spacing: WidthValues.spacingXs,
        children: [
          Icon(Icons.location_on, size: 16),
          Text(
            widget.location,
            style: ExtendedTextTheme.textSmall(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

class _SubContainer extends StatefulWidget {
  const _SubContainer({
    required this.title,
    required this.data,
    required this.function,
  });

  final String title;
  final String data;
  final VoidCallback function;

  @override
  State<_SubContainer> createState() => _SubContainerState();
}

class _SubContainerState extends State<_SubContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.function,
        child: Row(
          spacing: WidthValues.spacingSm,
          children: [
            Text(
              widget.data,
              style: ExtendedTextTheme.titleMedium(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.title,
              style: ExtendedTextTheme.textMedium(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
