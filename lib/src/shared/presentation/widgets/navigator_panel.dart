import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';

import '../../../core/theme/responsive.dart';
import '../../../core/utils/asset_images.dart';
import '../../../core/variables/values/values.dart';
import '../../../features/contact/contact.dart';
import '../../../features/home/presentation/bloc/chat_bloc/bloc.dart';
import '../../../features/settings/settings.dart';

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({super.key, required this.width});

  final double width;

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  bool _isExpanded = true;

  void toggleChat() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: _isExpanded ? 280 : 95,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorValues.bgBrandPrimary(context),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(WidthValues.radiusMd),
                bottomRight: Radius.circular(WidthValues.radiusMd),
              ),
            ),
            child: Column(
              spacing: 10,
              children: [
                // Lista de opciones fijas
                SizedBox(height: 64),
                _MainChatButton(
                  expanded: _isExpanded,
                  title: context.l10n.dashboardHomeButton,
                  iconData: Icons.home_outlined,
                  onPressed:
                      () => context.read<ChatBloc>().add(
                        GetChatMessages('home_chat'),
                      ),
                ),
                Expanded(
                  child: BlocBuilder<ChatBloc, ChatState>(
                    // buildWhen es una optimización: solo reconstruye si cambia el chatId
                    buildWhen:
                        (previous, current) =>
                            previous.chatId != current.chatId,
                    builder: (context, state) {
                      return ListView(
                        children: [
                          Divider(),
                          _TileOptionItem(
                            id: 1,
                            title: context.l10n.dashboardAboutMeButton,
                            routeName: 'about_chat',
                            icon: Icons.person_outlined,
                            expanded: _isExpanded,
                          ),
                          _TileOptionItem(
                            id: 2,
                            title: context.l10n.dashboardSkillsButton,
                            routeName: 'skills_chat',
                            icon: Icons.workspace_premium_rounded,
                            expanded: _isExpanded,
                          ),
                          _TileOptionItem(
                            id: 3,
                            title: context.l10n.dashboardProjectsButton,
                            routeName: 'projects_chat',
                            icon: Icons.chat_outlined,
                            expanded: _isExpanded,
                          ),
                          _TileOptionItem(
                            id: 4,
                            title: context.l10n.dashboardExperienceButton,
                            routeName: 'experience_chat',
                            icon: Icons.card_travel_rounded,
                            expanded: _isExpanded,
                          ),
                          _TileOptionItem(
                            id: 5,
                            title: context.l10n.dashboardEducationButton,
                            routeName: 'education_chat',
                            icon: Icons.school_outlined,
                            expanded: _isExpanded,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                _MainChatButton(
                  expanded: _isExpanded,
                  title: context.l10n.dashboardContactButton,
                  iconData: Icons.mail_outline_rounded,
                  onPressed:
                      () => showDialog(
                        context: context,
                        builder: (context) => const ContactDialog(),
                      ),
                ),
                _MainChatButton(
                  expanded: _isExpanded,
                  title: context.l10n.dashboardConfigButton,
                  iconData: Icons.settings_outlined,
                  onPressed:
                      () => showDialog(
                        context: context,
                        builder: (context) => const SettingsDialog(),
                      ),
                ),
                Gap(WidthValues.spacingNone),
              ],
            ),
          ),
          if (!Responsive.isMobile(context))
            Positioned(
              top: 10,
              right: 0,
              child: IconButton(
                icon: Icon(
                  _isExpanded ? Icons.chevron_left : Icons.chevron_right,
                ),
                onPressed: toggleChat,
                tooltip:
                    _isExpanded
                        ? context.l10n.dashboardClosePanelTooltip
                        : context.l10n.dashboardOpenPanelTooltip,
              ),
            ),
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundImage: AssetImage(AssetImages.profile),
              radius: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainChatButton extends StatelessWidget {
  const _MainChatButton({
    required this.expanded,
    required this.title,
    required this.iconData,
    required this.onPressed,
  });

  final String title;
  final IconData iconData;
  final bool expanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: expanded ? 8 : 0,
            children: [
              Flexible(child: Icon(iconData)),

              Flexible(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: expanded ? 1.0 : 0.0,
                  child: Text(title, overflow: TextOverflow.clip, maxLines: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _TileOptionItem extends StatelessWidget {
  const _TileOptionItem({
    required this.id,
    required this.title,
    this.icon = Icons.chevron_right_rounded,
    required this.routeName,
    required this.expanded,
  });

  final int id;
  final String title;
  final IconData icon;
  final String routeName;
  final bool expanded;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(WidthValues.radiusMd),
    ),
    child: ListTile(
      tileColor:
          context.read<ChatBloc>().getChatId() == id
              ? ColorValues.utilityBrand300(context)
              : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WidthValues.padding),
      ),
      leading: Icon(icon),
      title:
          (expanded)
              ? AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: expanded ? 1.0 : 0.0,
                child: Text(title, overflow: TextOverflow.clip, maxLines: 1),
              )
              : null,
      onTap: () => context.read<ChatBloc>().add(GetChatMessages(routeName)),
      hoverColor: ColorValues.utilityBrand300(context),
    ),
  );
}
