import 'package:flutter/material.dart';
import 'package:portafolio/src/shared/presentation/widgets/projects_body.dart';
import 'package:portafolio/src/shared/presentation/widgets/resume_body.dart';
import 'package:portafolio/src/shared/presentation/widgets/skills_body.dart';

import '../../../features/home/domain/entities/message.dart';
import '../../data/datasource/local/about.dart';
import '../../data/datasource/local/education.dart';
import '../../data/datasource/local/experience.dart';
import '../../data/datasource/local/projects.dart';
import '../../data/datasource/local/skills.dart';
import 'campus_banner.dart';
import 'certifications_body.dart';
import 'experience_body.dart';
import 'message_card.dart';

class MessageContent extends StatelessWidget {
  const MessageContent({super.key, required this.title, required this.content});

  final String title;
  final List<Message> content;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSystemMessage(title),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              interactive: true,
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                //padding: EdgeInsets.only(right: 16.0),
                itemCount: content.length,
                //separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  var widget;
                  if (content[index].contentCode != null) {
                    switch (content[index].contentCode) {
                      case 'resume':
                        widget = ResumeBody(aboutData: aboutData);
                        break;
                      case 'development_skills':
                        widget = SkillsBody(skills: developmentSkills);
                        break;
                      case 'tech_skills':
                        widget = SkillsBody(skills: techSkills);
                        break;
                      case 'office_skills':
                        widget = SkillsBody(skills: officeSkills);
                        break;
                      case 'projects':
                        widget = ProjectsBody(projects: projects);
                        break;
                      case 'timeline_experience':
                        widget = ExperienceTimeline(experience: experience);
                      case 'campus_banner':
                        widget = CampusBanner();
                        break;
                      case 'certifications':
                        widget = CertificationsBody(
                          certifications: certifications,
                        );
                        break;
                    }
                  }
                  return MessageCard(message: content[index], child: widget);
                },
              ),
            ),
          ),
          SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildSystemMessage(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
