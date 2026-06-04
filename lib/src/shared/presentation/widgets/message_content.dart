import 'package:flutter/material.dart';
import 'package:portafolio/src/shared/presentation/widgets/projects_body.dart';
import 'package:portafolio/src/shared/presentation/widgets/resume_body.dart';
import 'package:portafolio/src/shared/presentation/widgets/skills_body.dart';

import '../../../features/home/domain/entities/message.dart';
import '../../data/datasource/local/about.dart';
import '../../data/datasource/local/education.dart';
import '../../data/datasource/local/experience.dart';
import '../../data/datasource/local/projects.dart';
import '../../data/datasource/local/skills.dart'; // languageSkills, developmentSkills…
import 'campus_banner.dart';
import 'certifications_body.dart';
import 'experience_body.dart';
import 'languages_body.dart';
import 'message_card.dart';

// Max width of the centered chat content — mirrors the design's .chat-inner.
const double _kChatInnerMaxWidth = 880;

// Horizontal padding on each message row — matches the old Container padding.
const double _kChatPaddingH = 16;

class MessageContent extends StatelessWidget {
  const MessageContent({super.key, required this.title, required this.content});

  final String title;
  final List<Message> content;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // The Scrollbar wraps the full-width CustomScrollView so its thumb sits
    // at the right edge of the viewport, outside the centered content area.
    // This mirrors the design where .chat-scroll is full-width and .chat-inner
    // is centered at 880 px inside it.
    return SelectionArea(
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        interactive: true,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            // Vertical padding wrapping the whole list
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: _kChatPaddingH),
              sliver: SliverList.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  // Every item is independently centered at 880 px so the
                  // scrollbar thumb can live outside that box.
                  Widget? child;
                  final code = content[index].contentCode;
                  if (code != null) {
                    switch (code) {
                      case 'language_skills':
                        child = LanguagesBody(languages: languageSkills);
                      case 'resume':
                        child = ResumeBody(aboutData: aboutData);
                      case 'development_skills':
                        child = SkillsBody(skills: developmentSkills);
                      case 'tech_skills':
                        child = SkillsBody(skills: techSkills);
                      case 'office_skills':
                        child = SkillsBody(skills: officeSkills);
                      case 'projects':
                        child = ProjectsBody(projects: projects);
                      case 'timeline_experience':
                        child = ExperienceTimeline(experience: experience);
                      case 'campus_banner':
                        child = CampusBanner();
                      case 'certifications':
                        child = CertificationsBody(
                          certifications: certifications,
                        );
                    }
                  }

                  return Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _kChatInnerMaxWidth,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _kChatPaddingH,
                        ),
                        child: MessageCard(
                          message: content[index],
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
