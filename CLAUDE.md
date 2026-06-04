# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run web dev server
flutter run -d chrome

# Build for web (deployed via Vercel)
flutter build web

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Regenerate localization files after editing .arb files
flutter gen-l10n

# Analyze code
flutter analyze
```

## Architecture

This is a Flutter Web portfolio app. It follows a feature-first clean architecture with three layers per feature: `data`, `domain`, and `presentation`.

**Entry point:** `lib/main.dart` — bootstraps `GetIt` (via `setupLocator()`), wraps the app in a `ChangeNotifierProvider` for `AppProvider` (theme + locale), and mounts `MyHomePage`.

**Dependency injection:** `get_it` singleton via `lib/src/core/providers/get_providers.dart`. `AppProvider` is the only registered singleton currently.

**State management:** `flutter_bloc` (BLoC pattern). The main feature is `ChatBloc` in `lib/src/features/home/presentation/bloc/chat_bloc/`.

**Content data:** Portfolio content (chat messages/conversations, projects, experience, education, skills) lives as JSON/Dart data in `assets/data/` and `lib/src/shared/data/datasource/local/`. Chat messages are loaded from `assets/data/chats.json` via `GetChatMessagesDatasourceImpl`. The home screen renders as a chat UI using this data.

**Layout:** `BaseLayoutPage` (`lib/src/shared/presentation/widgets/base_layout.dart`) is the root scaffold for all screens. It renders a collapsible `NavigationPanel` sidebar on desktop (>600px) and a drawer on mobile.

**Localization:** English and Spanish, configured in `l10n.yaml`. ARB files are in `lib/l10n/`. Access strings via `context.l10n.*` (extension in `lib/l10n/l10n.dart`). After editing `.arb` files, run `flutter gen-l10n`.

**Theme:** `AppTheme` in `lib/src/core/theme/app_theme.dart` provides light/dark themes. `ExtendedTextTheme` adds custom text styles. Responsive breakpoints are in `lib/src/core/theme/responsive.dart`.

**Features:**
- `home` — main chat-style portfolio view with `ChatBloc`
- `contact` — contact modal with social/email buttons
- `settings` — theme and language toggles shown in a modal

**Shared widgets** in `lib/src/shared/presentation/widgets/` are used across features (e.g., `MessageCard`, `ProjectsCard`, `SkillsBody`, `ExperienceBody`).

**Deployment:** Vercel (`vercel.json` present). `flutter build web` output goes to `build/web`.