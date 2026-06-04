import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/asset_icons.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/variables/constants/constants.dart';
import '../../../core/variables/values/values.dart';

part '../widgets/contact_buttons.dart';

// ---------------------------------------------------------------------------
// ContactDialog
// ---------------------------------------------------------------------------

class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 700;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 780, maxHeight: 640),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _EmailFormPanel()),
                    Expanded(child: _SocialPanel()),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _EmailFormPanel(),
                      _SocialPanel(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Left panel — visual email form
// ---------------------------------------------------------------------------

class _EmailFormPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isEs =
        Localizations.localeOf(context).languageCode == 'es';

    return Container(
      color: ColorValues.bgSurface(context),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEs ? 'Envíame un correo' : 'Send me an email',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: ColorValues.textPrimary(context),
            ),
          ),
          const Gap(6),
          Text(
            isEs
                ? 'Cuéntame sobre tu proyecto o propuesta y te responderé pronto.'
                : "Tell me about your project or proposal and I'll get back to you soon.",
            style: TextStyle(
              fontSize: 14,
              color: ColorValues.textSecondary(context),
              height: 1.5,
            ),
          ),
          const Gap(24),
          _FormField(
            label: isEs ? 'Nombre' : 'Name',
            hint: isEs ? 'Tu nombre' : 'Your name',
          ),
          const Gap(16),
          _FormField(
            label: isEs ? 'Correo' : 'Email',
            hint: isEs ? 'tucorreo@ejemplo.com' : 'youremail@example.com',
          ),
          const Gap(16),
          _FormField(
            label: isEs ? 'Mensaje' : 'Message',
            hint: isEs ? 'Escribe tu mensaje...' : 'Write your message...',
            maxLines: 5,
          ),
          const Gap(24),
          _SendButton(isEs: isEs),
        ],
      ),
    );
  }
}

// ── Visual-only form field ──────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
  });

  final String label;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: ColorValues.textSecondary(context),
          ),
        ),
        const Gap(6),
        TextField(
          enabled: false,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorValues.textTertiary(context),
              fontSize: 14,
            ),
            filled: true,
            fillColor: ColorValues.bgChip(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorValues.borderChip(context),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorValues.borderChip(context),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorValues.borderChip(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Visual-only send button ─────────────────────────────────────────────────

class _SendButton extends StatelessWidget {
  const _SendButton({required this.isEs});
  final bool isEs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFF00E660),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          const Icon(Icons.send_rounded, color: Color(0xFF03331A), size: 17),
          const Gap(8),
          Text(
            isEs ? 'Enviar correo' : 'Send email',
            style: const TextStyle(
              color: Color(0xFF03331A),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Right panel — social channels
// ---------------------------------------------------------------------------

class _SocialPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isEs = Localizations.localeOf(context).languageCode == 'es';

    final channels = _buildChannels(context);

    return Container(
      color: ColorValues.bgSecondary(context),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close button row
          Align(
            alignment: Alignment.topRight,
            child: _CloseButton(),
          ),
          const Gap(4),
          Text(
            isEs ? 'O escríbeme por...' : 'Or write me on...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ColorValues.textPrimary(context),
            ),
          ),
          const Gap(4),
          Text(
            isEs
                ? 'Elige tu canal preferido y conversemos por ahí.'
                : 'Choose your preferred channel and let\'s talk.',
            style: TextStyle(
              fontSize: 13,
              color: ColorValues.textSecondary(context),
              height: 1.4,
            ),
          ),
          const Gap(16),
          ...channels.map(
            (ch) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _SocialChannelTile(channel: ch),
            ),
          ),
        ],
      ),
    );
  }

  List<_SocialChannel> _buildChannels(BuildContext context) {
    return [
      if (Constants.linkedinAccount.isNotEmpty)
        _SocialChannel(
          name: 'LinkedIn',
          handle: Constants.linkedinAccount,
          url: Constants.linkedinAccount,
          bgColor: const Color(0xFF0A66C2),
          iconPath: AssetIcons.iconLinkedin,
        ),
      if (Constants.githubAccount.isNotEmpty)
        _SocialChannel(
          name: 'GitHub',
          handle: Constants.githubAccount,
          url: Constants.githubAccount,
          bgColor: const Color(0xFF24292E),
          iconPath: AssetIcons.iconGithubLight,
        ),
      if (Constants.mainPhoneNumber.isNotEmpty)
        _SocialChannel(
          name: 'WhatsApp',
          handle: Constants.mainPhoneNumber,
          url: Helpers.whatsMee(
            context: context,
            number: Constants.mainPhoneNumber,
          ),
          bgColor: const Color(0xFF25D366),
          iconPath: AssetIcons.iconWhatsApp,
        ),
      if (Constants.gmailAccount.isNotEmpty)
        _SocialChannel(
          name: 'Gmail',
          handle: Constants.gmailAccount,
          url: 'mailto:${Constants.gmailAccount}',
          bgColor: const Color(0xFFEA4335),
          iconPath: AssetIcons.iconGmail,
        ),
    ];
  }
}
