import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:portafolio/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/extended_text_theme.dart';
import '../../../core/utils/asset_icons.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/variables/constants/constants.dart';
import '../../../core/variables/values/values.dart';
import '../../../shared/presentation/modal/custom_modal.dart';

part '../widgets/contact_buttons.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key});

  @override
  Widget build(BuildContext context) => CustomModal(
    title: context.l10n.contactPageLabel,
    maxWidth: 500,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Wrap(
        spacing: WidthValues.spacingSm,
        runSpacing: WidthValues.spacingSm,
        alignment: WrapAlignment.center,
        children: [
          _ContactButton(
            assetIcon: AssetIcons.iconGmail,
            label: StringConstants.gmail,
            onTapRoute: Helpers.sendMeEmail(),
          ),
          _ContactButton(
            assetIcon: AssetIcons.iconLinkedin,
            label: StringConstants.linkedin,
            onTapRoute: Constants.linkedinAccount,
          ),
          _ContactButton(
            assetIcon: AssetIcons.iconWhatsApp,
            label: StringConstants.whatsApp,
            onTapRoute: Helpers.whatsMee(
              context: context,
              number: Constants.mainPhoneNumber,
            ),
          ),
        ],
      ),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.closeButtonLabel), // "Close"
        ),
      ),
    ],
  );
}
