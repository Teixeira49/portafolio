part of '../page/home_page.dart';

// Composer max width mirrors the design (760px home slot)
const double _kComposerMaxWidth = 760.0;

// ─────────────────────────────────────────────────────────────────────────────
// Welcome content — title + subtitle + placeholder gap + social buttons.
// The composer is NOT included here; HomeBody places it as a separate layer.
// composerPlaceholderHeight keeps the column layout identical to the design
// so the title / buttons sit at exactly the right vertical positions.
// ─────────────────────────────────────────────────────────────────────────────

class _WelcomeContentOnly extends StatelessWidget {
  const _WelcomeContentOnly({required this.composerPlaceholderHeight});
  final double composerPlaceholderHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _kComposerMaxWidth + 120),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: WidthValues.spacingXl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TitleChatHomeWidget(),
              Gap(WidthValues.padding),
              _SubTitleChatHomeWidget(),
              const Gap(46),
              // Transparent placeholder — reserves the space the composer occupies
              // so the social buttons below align with the design layout.
              SizedBox(height: composerPlaceholderHeight),
              const Gap(34),
              const _ButtonsMenu(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Chat content — top bar + message list.
// Rendered as Layer 2 (chat opacity) in HomeBody's Stack.
// composerHeight is used as bottom padding so messages never hide behind the
// composer bar.
// ─────────────────────────────────────────────────────────────────────────────

class _ChatContent extends StatelessWidget {
  const _ChatContent({
    super.key,
    required this.chatName,
    required this.messages,
    required this.composerHeight,
  });

  final String chatName;
  final List<Message> messages;
  final double composerHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top bar: title centered + section badge pinned to the right
        if (!Responsive.isMobile(context))
          Padding(
            padding: EdgeInsets.fromLTRB(
              WidthValues.spacingMd,
              WidthValues.padding,
              WidthValues.spacingMd,
              0,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Title always centered regardless of badge width
                Text(
                  context.l10n.appTitle,
                  style: ExtendedTextTheme.titleMedium(context),
                  textAlign: TextAlign.center,
                ),
                // Badge pinned to the right edge
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTitleBadged(name: chatName),
                ),
              ],
            ),
          ),
        // Message list with bottom padding to clear the floating composer
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: WidthValues.spacing2xl,
              bottom: composerHeight + 12,
            ),
            child: MessageContent(title: chatName, content: messages),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Chat loading skeleton — pulsing placeholder shown while a chat is loading
// ─────────────────────────────────────────────────────────────────────────────

class _ChatLoadingSkeleton extends StatefulWidget {
  const _ChatLoadingSkeleton({super.key, required this.composerHeight});
  final double composerHeight;

  @override
  State<_ChatLoadingSkeleton> createState() => _ChatLoadingSkeletonState();
}

class _ChatLoadingSkeletonState extends State<_ChatLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _block({required double width, double height = 14, double radius = 8}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, __) => Opacity(
        opacity: 0.25 + _pulse.value * 0.2,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  Widget _botRow(BuildContext context, {int lines = 2}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar circle
        AnimatedBuilder(
          animation: _pulse,
          builder: (_, __) => Opacity(
            opacity: 0.25 + _pulse.value * 0.2,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _block(width: 100, height: 13),
              const Gap(10),
              for (int i = 0; i < lines; i++) ...[
                _block(
                  width: double.infinity,
                  height: 13,
                ),
                const Gap(8),
              ],
              _block(width: 160, height: 13),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _block(width: 60, height: 13),
        const Gap(10),
        Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            alignment: Alignment.centerRight,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) => Opacity(
                opacity: 0.25 + _pulse.value * 0.2,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: WidthValues.spacing2xl,
        bottom: widget.composerHeight + 12,
        left: WidthValues.spacingMd,
        right: WidthValues.spacingMd,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 880),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _userRow(context),
              const Gap(28),
              _botRow(context, lines: 2),
              const Gap(28),
              _userRow(context),
              const Gap(28),
              _botRow(context, lines: 4),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cloud — three blurred coloured blobs with a continuous drift animation.
// Mirrors the CSS .cloud element from design/Teixeira Portfolio.html.
// ─────────────────────────────────────────────────────────────────────────────

class _CloudWidget extends StatefulWidget {
  const _CloudWidget();

  @override
  State<_CloudWidget> createState() => _CloudWidgetState();
}

class _CloudWidgetState extends State<_CloudWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _driftX;
  late final Animation<double> _driftY;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();

    // CSS keyframes: 0% → 50% (14,-10,1.05) → 100% (-12,8,1.02)
    _driftX = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 14.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 14.0, end: -12.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_ctrl);

    _driftY = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -10.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -10.0, end: 8.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_ctrl);

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.05)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.05, end: 1.02)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final opacity = isDark ? 0.85 : 0.55;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: Transform.translate(
          offset: Offset(_driftX.value, _driftY.value),
          child: child,
        ),
      ),
      child: Opacity(
        opacity: opacity,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: isDark ? 70 : 55,
            sigmaY: isDark ? 70 : 55,
          ),
          child: CustomPaint(
            painter: _CloudPainter(
              green: ColorValues.cloudBlobGreen(context),
              red: ColorValues.cloudBlobRed(context),
              blue: ColorValues.cloudBlobBlue(context),
            ),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class _CloudPainter extends CustomPainter {
  const _CloudPainter({
    required this.green,
    required this.red,
    required this.blue,
  });

  final Color green;
  final Color red;
  final Color blue;

  @override
  void paint(Canvas canvas, Size size) {
    void drawBlob(Alignment center, double radius, Color color) {
      final cx = (center.x + 1) / 2 * size.width;
      final cy = (center.y + 1) / 2 * size.height;
      final r = radius * size.longestSide;
      canvas.drawRect(
        Offset.zero & size,
        Paint()
          ..shader = RadialGradient(
            colors: [color, Colors.transparent],
          ).createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: r),
          ),
      );
    }

    // green blob — 38%/60% at 26%/42% → Alignment(-0.48, -0.16)
    drawBlob(const Alignment(-0.48, -0.16), 0.62, green);
    // red blob  — 40%/64% at 76%/60% → Alignment(0.52, 0.20)
    drawBlob(const Alignment(0.52, 0.20), 0.70, red);
    // blue blob — 54%/80% at 52%/52% → Alignment(0.04, 0.04)
    drawBlob(const Alignment(0.04, 0.04), 0.82, blue);
  }

  @override
  bool shouldRepaint(_CloudPainter old) =>
      old.green != green || old.red != red || old.blue != blue;
}

// ─────────────────────────────────────────────────────────────────────────────
// Composer — glassmorphism container with blur backdrop
// ─────────────────────────────────────────────────────────────────────────────

class _ChatTextFieldWidget extends StatefulWidget {
  const _ChatTextFieldWidget();

  @override
  State<_ChatTextFieldWidget> createState() => _ChatTextFieldWidgetState();
}

class _ChatTextFieldWidgetState extends State<_ChatTextFieldWidget> {
  bool _isOpen = false;

  void _toggle() => setState(() => _isOpen = !_isOpen);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (prev, curr) => prev.chatRoute != curr.chatRoute && curr.chatRoute == 'home_chat',
      listener: (_, __) => setState(() => _isOpen = false),
      child: GestureDetector(
        onTap: _toggle,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
              decoration: BoxDecoration(
                color: ColorValues.bgSurface(context),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: _isOpen
                      ? ColorValues.borderSurfaceFocus(context)
                      : ColorValues.borderSurface(context),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: _isOpen ? 0.8 : 0.7),
                    blurRadius: _isOpen ? 70 : 60,
                    spreadRadius: _isOpen ? -22 : -20,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: _isOpen
                    ? const _QuestionMenu(key: ValueKey('menu'))
                    : const _ComposerDefault(key: ValueKey('default')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Default composer state: search row + actions row
// ─────────────────────────────────────────────────────────────────────────────

class _ComposerDefault extends StatelessWidget {
  const _ComposerDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input row — search icon + placeholder
        Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 22,
              color: ColorValues.textTertiary(context),
            ),
            const Gap(12),
            Expanded(
              child: Text(
                context.l10n.homePageQuestionLayer,
                style: TextStyle(
                  fontSize: 16.5,
                  color: ColorValues.textTertiary(context),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Gap(14),
        // Actions row — model pill · spacer · round button · CV button
        Row(
          children: [
            _ModelPill(),
            const Spacer(),
            _RoundButton(),
            const Gap(8),
            _CvButton(),
          ],
        ),
      ],
    );
  }
}

// ── Model pill — current model name + chevron dropdown ───────────────────────

class _ModelPill extends StatefulWidget {
  @override
  State<_ModelPill> createState() => _ModelPillState();
}

class _ModelPillState extends State<_ModelPill> {
  bool _hovered = false;
  OverlayEntry? _dropdownEntry;

  void _openDropdown() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final size = box.size;
    final currentModel = getIt<AppProvider>().selectedModel;
    final isHome = context.read<ChatBloc>().getChatId() == 0;
    final screenHeight = MediaQuery.of(context).size.height;

    _dropdownEntry = OverlayEntry(
      builder: (ctx) => _ModelDropdown(
        anchorTop: isHome ? pos.dy + size.height + 6 : null,
        anchorBottom: isHome ? null : screenHeight - pos.dy + 6,
        anchorLeft: pos.dx,
        selectedModel: currentModel,
        onClose: _closeDropdown,
        onSelect: (model) {
          getIt<AppProvider>().setModel(model);
          _closeDropdown();
        },
      ),
    );
    Overlay.of(context).insert(_dropdownEntry!);
  }

  void _closeDropdown() {
    _dropdownEntry?.remove();
    _dropdownEntry = null;
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: getIt<AppProvider>(),
      builder: (context, _) {
        final model = getIt<AppProvider>().selectedModel;
        final modelName = model == AppModel.flash ? 'Teixeira Flash' : 'Teixeira Pro';
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: _openDropdown,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _hovered
                    ? ColorValues.bgChipHover(context)
                    : ColorValues.bgChip(context),
                border: Border.all(color: ColorValues.borderChip(context)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    modelName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _hovered
                          ? ColorValues.textPrimary(context)
                          : ColorValues.textSecondary(context),
                    ),
                  ),
                  const Gap(8),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 15,
                    color: _hovered
                        ? ColorValues.textPrimary(context)
                        : ColorValues.textSecondary(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Model dropdown overlay ────────────────────────────────────────────────────

class _ModelDropdown extends StatelessWidget {
  const _ModelDropdown({
    this.anchorTop,
    this.anchorBottom,
    required this.anchorLeft,
    required this.selectedModel,
    required this.onClose,
    required this.onSelect,
  });

  final double? anchorTop;
  final double? anchorBottom;
  final double anchorLeft;
  final AppModel selectedModel;
  final VoidCallback onClose;
  final void Function(AppModel) onSelect;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final menuBg = isDark ? const Color(0xFF202223) : Colors.white;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
        ),
        Positioned(
          top: anchorTop,
          bottom: anchorBottom,
          left: anchorLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                color: menuBg,
                border: Border.all(color: ColorValues.borderLine(context)),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDark ? 0.4 : 0.12,
                    ),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ModelDropdownItem(
                    label: 'Flash',
                    subtitle: context.l10n.modelFlashSubtitle,
                    isSelected: selectedModel == AppModel.flash,
                    onTap: () => onSelect(AppModel.flash),
                  ),
                  _ModelDropdownItem(
                    label: 'Pro',
                    subtitle: context.l10n.modelProSubtitle,
                    isSelected: selectedModel == AppModel.pro,
                    onTap: () => onSelect(AppModel.pro),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Model dropdown item ───────────────────────────────────────────────────────

class _ModelDropdownItem extends StatefulWidget {
  const _ModelDropdownItem({
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_ModelDropdownItem> createState() => _ModelDropdownItemState();
}

class _ModelDropdownItemState extends State<_ModelDropdownItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? primaryColor.withAlpha(30)
                : _hovered
                    ? ColorValues.bgSidebarHover(context)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Teixeira ${widget.label}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: widget.isSelected
                            ? primaryColor
                            : ColorValues.textPrimary(context),
                      ),
                    ),
                    const Gap(2),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: ColorValues.textTertiary(context),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isSelected)
                Icon(Icons.check_rounded, size: 16, color: primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Round icon button ─────────────────────────────────────────────────────────

class _RoundButton extends StatefulWidget {
  @override
  State<_RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<_RoundButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _hovered
              ? ColorValues.bgChipHover(context)
              : ColorValues.bgChip(context),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add_rounded,
          size: 20,
          color: _hovered
              ? ColorValues.textPrimary(context)
              : ColorValues.textSecondary(context),
        ),
      ),
    );
  }
}

// ── CV / Currículum button — blue pill ───────────────────────────────────────

class _CvButton extends StatefulWidget {
  @override
  State<_CvButton> createState() => _CvButtonState();
}

class _CvButtonState extends State<_CvButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(Constants.resume)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF1F55C4).withValues(alpha: 0.85)
                : const Color(0xFF1F55C4),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.download_outlined,
                color: Colors.white,
                size: 18,
              ),
              const Gap(9),
              Text(
                context.l10n.homePageDownloadResumeButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
