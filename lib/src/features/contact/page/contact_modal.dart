import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/asset_icons.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/variables/values/values.dart';

part '../widgets/contact_buttons.dart';

const _emailJsServiceId = 'service_5h6tket';
const _emailJsTemplateId = 'template_hq7hevs';
const _emailJsPublicKey = 'Z80TJ3jprMnReQuF_';

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
        constraints: const BoxConstraints(maxWidth: 780, maxHeight: 680),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ColorValues.borderLine(context)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(180),
                    blurRadius: 90,
                    spreadRadius: -20,
                    offset: const Offset(0, 30),
                  ),
                ],
              ),
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
            Positioned(
              top: 12,
              right: 12,
              child: _CloseButton(),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Left panel — functional email form
// ---------------------------------------------------------------------------

class _EmailFormPanel extends StatefulWidget {
  @override
  State<_EmailFormPanel> createState() => _EmailFormPanelState();
}

class _EmailFormPanelState extends State<_EmailFormPanel> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _loading = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);

    try {
      final response = await Dio().post<dynamic>(
        'https://api.emailjs.com/api/v1.0/email/send',
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (s) => s != null,
        ),
        data: {
          'service_id': _emailJsServiceId,
          'template_id': _emailJsTemplateId,
          'user_id': _emailJsPublicKey,
          'template_params': {
            'from_name': _nameController.text.trim(),
            'from_email': _emailController.text.trim(),
            'message': _messageController.text.trim(),
          },
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          _sent = true;
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
        _showSnack(context, isEs: _isEs, success: false);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      _showSnack(context, isEs: _isEs, success: false);
    }
  }

  bool get _isEs => Localizations.localeOf(context).languageCode == 'es';

  @override
  Widget build(BuildContext context) {
    final isEs = _isEs;

    return Container(
      color: ColorValues.bgSurface(context),
      padding: const EdgeInsets.all(32),
      child: _sent ? _SuccessView(isEs: isEs) : _buildForm(isEs),
    );
  }

  Widget _buildForm(bool isEs) {
    return Form(
      key: _formKey,
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
          _ActiveFormField(
            label: isEs ? 'Nombre' : 'Name',
            hint: isEs ? 'Tu nombre' : 'Your name',
            controller: _nameController,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? (isEs ? 'Requerido' : 'Required') : null,
          ),
          const Gap(16),
          _ActiveFormField(
            label: isEs ? 'Correo' : 'Email',
            hint: isEs ? 'tucorreo@ejemplo.com' : 'youremail@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return isEs ? 'Requerido' : 'Required';
              }
              final valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
              return valid ? null : (isEs ? 'Correo inválido' : 'Invalid email');
            },
          ),
          const Gap(16),
          _ActiveFormField(
            label: isEs ? 'Mensaje' : 'Message',
            hint: isEs ? 'Escribe tu mensaje...' : 'Write your message...',
            controller: _messageController,
            maxLines: 5,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? (isEs ? 'Requerido' : 'Required') : null,
          ),
          const Gap(24),
          _SendButton(isEs: isEs, loading: _loading, onPressed: _send),
        ],
      ),
    );
  }
}

void _showSnack(
  BuildContext context, {
  required bool isEs,
  required bool success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        success
            ? (isEs ? '¡Mensaje enviado!' : 'Message sent!')
            : (isEs ? 'Error al enviar. Inténtalo de nuevo.' : 'Failed to send. Please try again.'),
      ),
      backgroundColor: success ? const Color(0xFF00E660) : Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

// ── Success state ───────────────────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.isEs});
  final bool isEs;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFF00E660),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_rounded, color: Color(0xFF03331A), size: 36),
          ),
          const Gap(20),
          Text(
            isEs ? '¡Mensaje enviado!' : 'Message sent!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorValues.textPrimary(context),
            ),
          ),
          const Gap(8),
          Text(
            isEs
                ? 'Gracias por escribir. Te responderé pronto.'
                : "Thanks for reaching out. I'll get back to you soon.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: ColorValues.textSecondary(context),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Active form field with validation ──────────────────────────────────────

class _ActiveFormField extends StatelessWidget {
  const _ActiveFormField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

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
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            fontSize: 14,
            color: ColorValues.textPrimary(context),
          ),
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
              borderSide: BorderSide(color: ColorValues.borderChip(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorValues.borderChip(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF00E660), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Send button ─────────────────────────────────────────────────────────────

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.isEs,
    required this.loading,
    required this.onPressed,
  });

  final bool isEs;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 46,
        decoration: BoxDecoration(
          color: loading ? const Color(0xFF00E660).withAlpha(153) : const Color(0xFF00E660),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(20),
            if (loading)
              const SizedBox(
                width: 17,
                height: 17,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF03331A),
                ),
              )
            else
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
                : "Choose your preferred channel and let's talk.",
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
      _SocialChannel(
        name: 'WhatsApp',
        handle: '+58 424 323 8366',
        url: Helpers.whatsMee(context: context, number: '584243238366'),
        bgColor: const Color(0xFF25D366),
        iconPath: AssetIcons.iconWhatsApp,
      ),
      _SocialChannel(
        name: 'Instagram',
        handle: '@javier_a_teixeira._g',
        url: 'https://www.instagram.com/javier_a_teixeira._g/',
        bgColor: const Color(0xFFE1306C),
        iconPath: AssetIcons.iconInstagram,
      ),
      _SocialChannel(
        name: 'LinkedIn',
        handle: 'ing-javier-teixeira',
        url: 'https://www.linkedin.com/in/ing-javier-teixeira/',
        bgColor: const Color(0xFF0A66C2),
        iconPath: AssetIcons.iconLinkedin,
      ),
      _SocialChannel(
        name: 'GitHub',
        handle: '@teixeira49',
        url: 'https://github.com/teixeira49',
        bgColor: const Color(0xFF24292E),
        iconPath: AssetIcons.iconGithubLight,
      ),
      _SocialChannel(
        name: 'Telegram',
        handle: '',
        url: '',
        bgColor: const Color(0xFF229ED9),
        iconPath: AssetIcons.iconTelegram,
        comingSoon: true,
      ),
    ];
  }
}
