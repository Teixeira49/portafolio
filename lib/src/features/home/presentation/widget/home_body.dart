part of '../page/home_page.dart';

// Approximate closed-state height of _ChatTextFieldWidget.
// Input row (26) + gap (14) + actions row (42) + vertical padding (32) ≈ 114px
const double _kComposerClosedHeight = 114.0;

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // Cached chat content used while the animation plays
  List<Message> _chatMessages = const [];
  String _chatName = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status &&
          (curr.status.isLoading || curr.status.isLoaded),
      listener: (context, state) {
        if (state.status.isLoading) {
          setState(() => _isLoading = true);
        } else if (state.chatName == 'Home Chat') {
          setState(() => _isLoading = false);
          _ctrl.reverse();
        } else {
          setState(() {
            _isLoading = false;
            _chatMessages = state.messages;
            _chatName = state.chatName;
          });
          _ctrl.forward();
        }
      },
      buildWhen: (prev, curr) =>
          prev.status != curr.status ||
          prev.chatName != curr.chatName ||
          prev.chatId != curr.chatId,
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: _ctrl,
              // _ChatTextFieldWidget is the AnimatedBuilder child so it is
              // built only once and its state (_isOpen) is preserved across
              // every animation frame.
              child: const _ChatTextFieldWidget(),
              builder: (context, composerWidget) {
                final t = _ctrl.value;

                // ── Opacity phases ──────────────────────────────────────
                // Home:  1→0 during first 40 %
                // Chat:  0→1 during last  40 %
                final homeOpacity = (1.0 - t / 0.40).clamp(0.0, 1.0);
                final chatOpacity = ((t - 0.60) / 0.40).clamp(0.0, 1.0);

                // ── Composer movement (0 → 1, eased over full duration) ─
                final moveProg =
                    Curves.easeInOutCubic.transform(t);

                // ── Calculate home Y for the composer ───────────────────
                // Mirrors the column layout inside _WelcomeContentOnly:
                //   title + gap8 + subtitle + gap46 = ~150 px above
                //   gap34 + buttons                 = ~ 78 px below
                const aboveH = 150.0;
                const belowH = 78.0;
                const composerH = _kComposerClosedHeight;
                const totalH = aboveH + composerH + belowH;

                final availH = constraints.maxHeight;
                final composerCenterY =
                    ((availH - totalH) / 2 + aboveH + composerH / 2)
                        .clamp(composerH, availH - composerH);

                final homeAlignY =
                    ((composerCenterY * 2 / availH) - 1.0)
                        .clamp(-0.95, 0.95);

                final composerAlign = Alignment.lerp(
                  Alignment(0, homeAlignY),
                  Alignment.bottomCenter,
                  moveProg,
                )!;

                // ── Lerp helper ─────────────────────────────────────────
                double lerp(double a, double b, double p) => a + (b - a) * p;

                // ── Cloud bounds — home state ────────────────────────────
                // Extends 60 px beyond the composer on each side (matches
                // the CSS inset: -90px -60px -120px of the .cloud element).
                final cloudHPad0 =
                    ((constraints.maxWidth - _kComposerMaxWidth) / 2 - 60)
                        .clamp(0.0, double.infinity);
                final cloudTop0 =
                    (composerCenterY - composerH / 2 - 90).clamp(0.0, availH);
                final cloudBottom0 =
                    (availH - composerCenterY - composerH / 2 - 120)
                        .clamp(0.0, availH);

                // ── Cloud bounds — chat state ────────────────────────────
                // Composer sits at Alignment.bottomCenter with padding 16.
                // Cloud extends above and below (bottom clamped to 0 so it
                // bleeds off-screen naturally).
                final chatComposerTop = availH - 16 - composerH;
                final cloudHPad1 =
                    ((constraints.maxWidth - 880) / 2 - 60)
                        .clamp(0.0, double.infinity);
                final cloudTop1 = (chatComposerTop - 90).clamp(0.0, availH);
                const cloudBottom1 = 0.0;

                // ── Cloud bounds — interpolated ──────────────────────────
                final cloudLeft   = lerp(cloudHPad0, cloudHPad1, moveProg);
                final cloudRight  = lerp(cloudHPad0, cloudHPad1, moveProg);
                final cloudTop    = lerp(cloudTop0,  cloudTop1,  moveProg);
                final cloudBottom = lerp(cloudBottom0, cloudBottom1, moveProg);

                return Stack(
                  children: [
                    // ── Layer 0 — Persistent cloud (always visible) ───────
                    // Follows the composer from center-screen to bottom as
                    // moveProg goes 0→1. Sits below all content layers so
                    // it never obscures text.
                    Positioned(
                      left: cloudLeft,
                      right: cloudRight,
                      top: cloudTop,
                      bottom: cloudBottom,
                      child: const _CloudWidget(),
                    ),

                    // ── Layer 1 — Home content (fades out) ───────────────
                    if (homeOpacity > 0)
                      Opacity(
                        opacity: homeOpacity,
                        child: _WelcomeContentOnly(
                          composerPlaceholderHeight: composerH,
                        ),
                      ),

                    // ── Layer 2 — Chat content (fades in) ─────────────────
                    // AnimatedSwitcher handles chat↔chat cross-fades and
                    // swaps in a skeleton while the next chat is loading.
                    if (chatOpacity > 0)
                      Opacity(
                        opacity: chatOpacity,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 320),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: _isLoading
                              ? _ChatLoadingSkeleton(
                                  key: const ValueKey('__loading__'),
                                  composerHeight: composerH,
                                )
                              : _ChatContent(
                                  key: ValueKey(_chatName),
                                  chatName: _chatName,
                                  messages: _chatMessages,
                                  composerHeight: composerH,
                                ),
                        ),
                      ),

                    // ── Layer 3 — Composer (always visible, animates pos) ─
                    Align(
                      alignment: composerAlign,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          lerp(Responsive.isMobile(context) ? 16.0 : 0.0, 16, moveProg),
                          0,
                          lerp(Responsive.isMobile(context) ? 16.0 : 0.0, 16, moveProg),
                          lerp(0, 16, moveProg),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: lerp(
                              _kComposerMaxWidth,
                              880,
                              moveProg,
                            ),
                          ),
                          child: composerWidget,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
