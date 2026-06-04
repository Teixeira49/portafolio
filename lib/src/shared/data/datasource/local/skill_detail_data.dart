import 'package:flutter/material.dart';

/// Detail info for each skill, used by [SkillDetailModal].
/// Keys are normalized (lowercase, no spaces/special chars) to match
/// how skill names are stored in skills.dart.
class SkillDetail {
  const SkillDetail({
    required this.categoryEs,
    required this.categoryEn,
    required this.descEs,
    required this.descEn,
    required this.uses,
    required this.accentColor,
  });

  final String categoryEs;
  final String categoryEn;
  final String descEs;
  final String descEn;
  /// Uses shown as chips — mostly technical terms, same for both locales.
  final List<String> uses;
  final Color accentColor;

  String category(bool isEs) => isEs ? categoryEs : categoryEn;
  String desc(bool isEs) => isEs ? descEs : descEn;
}

String normalizeKey(String name) =>
    name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

const Map<String, SkillDetail> skillDetailData = {
  'python': SkillDetail(
    categoryEs: 'Lenguaje de programación',
    categoryEn: 'Programming language',
    descEs: 'Lenguaje versátil y legible, ideal para backend, automatización y procesamiento de datos.',
    descEn: 'Versatile and readable language, ideal for backend, automation and data processing.',
    uses: ['Backend', 'APIs', 'Web Scraping', 'Scripting'],
    accentColor: Color(0xFF3776AB),
  ),
  'java': SkillDetail(
    categoryEs: 'Lenguaje de programación',
    categoryEn: 'Programming language',
    descEs: 'Lenguaje robusto y multiplataforma, ampliamente usado en sistemas empresariales.',
    descEn: 'Robust, cross-platform language widely used in enterprise systems.',
    uses: ['Backend', 'Microservicios'],
    accentColor: Color(0xFFE76F00),
  ),
  'html': SkillDetail(
    categoryEs: 'Lenguaje de marcado',
    categoryEn: 'Markup language',
    descEs: 'Estructura base de cualquier página web mediante etiquetas semánticas.',
    descEn: 'The foundation of any web page through semantic tags.',
    uses: ['Estructura web', 'Contenido'],
    accentColor: Color(0xFFE34F26),
  ),
  'css': SkillDetail(
    categoryEs: 'Lenguaje de estilos',
    categoryEn: 'Style language',
    descEs: 'Lenguaje para dar estilo, color y disposición a las páginas web.',
    descEn: 'Language for styling, coloring and laying out web pages.',
    uses: ['Diseño web', 'Layouts', 'Animaciones'],
    accentColor: Color(0xFF1572B6),
  ),
  'javascript': SkillDetail(
    categoryEs: 'Lenguaje de programación',
    categoryEn: 'Programming language',
    descEs: 'Lenguaje de la web para añadir interactividad en el navegador y el servidor.',
    descEn: 'The language of the web for adding interactivity on both browser and server.',
    uses: ['Web', 'Frontend', 'Lógica'],
    accentColor: Color(0xFFF7DF1E),
  ),
  'springboot': SkillDetail(
    categoryEs: 'Framework backend',
    categoryEn: 'Backend framework',
    descEs: 'Framework de Java para crear servicios y microservicios listos para producción.',
    descEn: 'Java framework for creating production-ready services and microservices.',
    uses: ['Microservicios', 'APIs'],
    accentColor: Color(0xFF6DB33F),
  ),
  'fastapi': SkillDetail(
    categoryEs: 'Framework backend',
    categoryEn: 'Backend framework',
    descEs: 'Framework moderno de Python para construir APIs rápidas con validación y documentación automática.',
    descEn: 'Modern Python framework for building fast APIs with automatic validation and documentation.',
    uses: ['APIs REST', 'Microservicios'],
    accentColor: Color(0xFF009688),
  ),
  'nodejs': SkillDetail(
    categoryEs: 'Entorno de ejecución',
    categoryEn: 'Runtime environment',
    descEs: 'Runtime de JavaScript del lado del servidor para construir servicios de red eficientes.',
    descEn: 'Server-side JavaScript runtime for building efficient network services.',
    uses: ['Backend', 'APIs', 'Tiempo real'],
    accentColor: Color(0xFF5FA04E),
  ),
  'nestjs': SkillDetail(
    categoryEs: 'Framework backend',
    categoryEn: 'Backend framework',
    descEs: 'Framework de Node.js con arquitectura modular y tipada para backends escalables.',
    descEn: 'Node.js framework with a modular, typed architecture for scalable backends.',
    uses: ['APIs', 'Microservicios'],
    accentColor: Color(0xFFE0234E),
  ),
  'flutter': SkillDetail(
    categoryEs: 'Framework multiplataforma',
    categoryEn: 'Cross-platform framework',
    descEs: 'SDK de Google para construir apps multiplataforma con una sola base de código.',
    descEn: "Google's SDK for building cross-platform apps from a single codebase.",
    uses: ['Apps móviles', 'Multiplataforma', 'UI'],
    accentColor: Color(0xFF02569B),
  ),
  'flet': SkillDetail(
    categoryEs: 'Framework',
    categoryEn: 'Framework',
    descEs: 'Framework para crear interfaces multiplataforma usando solo Python.',
    descEn: 'Framework for building cross-platform interfaces using only Python.',
    uses: ['Apps con Python', 'Prototipos'],
    accentColor: Color(0xFF00C8FF),
  ),
  'kotlin': SkillDetail(
    categoryEs: 'Lenguaje de programación',
    categoryEn: 'Programming language',
    descEs: 'Lenguaje moderno y conciso, interoperable con Java y usado en Android.',
    descEn: 'Modern, concise language interoperable with Java and used in Android.',
    uses: ['Android', 'Backend'],
    accentColor: Color(0xFF7F52FF),
  ),
  'tailwindcss': SkillDetail(
    categoryEs: 'Framework de estilos',
    categoryEn: 'CSS framework',
    descEs: 'Framework CSS utility-first para diseñar interfaces rápidamente.',
    descEn: 'Utility-first CSS framework for designing interfaces quickly.',
    uses: ['Diseño web', 'UI'],
    accentColor: Color(0xFF06B6D4),
  ),
  'react': SkillDetail(
    categoryEs: 'Librería frontend',
    categoryEn: 'Frontend library',
    descEs: 'Librería de JavaScript para construir interfaces de usuario basadas en componentes.',
    descEn: 'JavaScript library for building component-based user interfaces.',
    uses: ['Web SPA', 'UI', 'Frontend'],
    accentColor: Color(0xFF61DAFB),
  ),
  'postgressql': SkillDetail(
    categoryEs: 'Base de datos',
    categoryEn: 'Database',
    descEs: 'Motor relacional robusto y de código abierto para datos estructurados y consultas complejas.',
    descEn: 'Robust open-source relational engine for structured data and complex queries.',
    uses: ['Persistencia', 'Datos relacionales'],
    accentColor: Color(0xFF4169E1),
  ),
  'postgresql': SkillDetail(
    categoryEs: 'Base de datos',
    categoryEn: 'Database',
    descEs: 'Motor relacional robusto y de código abierto para datos estructurados y consultas complejas.',
    descEn: 'Robust open-source relational engine for structured data and complex queries.',
    uses: ['Persistencia', 'Datos relacionales'],
    accentColor: Color(0xFF4169E1),
  ),
  'firebase': SkillDetail(
    categoryEs: 'Backend como servicio',
    categoryEn: 'Backend as a service',
    descEs: 'Plataforma de Google con base de datos en tiempo real, autenticación y hosting.',
    descEn: "Google's platform with real-time database, authentication and hosting.",
    uses: ['Auth', 'Realtime DB', 'Hosting'],
    accentColor: Color(0xFFFFCA28),
  ),
  'github': SkillDetail(
    categoryEs: 'Control de versiones',
    categoryEn: 'Version control',
    descEs: 'Plataforma de alojamiento de repositorios Git para colaboración y control de versiones.',
    descEn: 'Git repository hosting platform for collaboration and version control.',
    uses: ['Git', 'Colaboración', 'CI/CD'],
    accentColor: Color(0xFF24292E),
  ),
  'postman': SkillDetail(
    categoryEs: 'Herramienta de APIs',
    categoryEn: 'API tool',
    descEs: 'Plataforma para probar, documentar y depurar APIs de forma visual.',
    descEn: 'Platform for visually testing, documenting and debugging APIs.',
    uses: ['Pruebas de API', 'Documentación'],
    accentColor: Color(0xFFFF6C37),
  ),
  'slack': SkillDetail(
    categoryEs: 'Comunicación de equipo',
    categoryEn: 'Team communication',
    descEs: 'Plataforma de mensajería para la colaboración y comunicación de equipos.',
    descEn: 'Messaging platform for team collaboration and communication.',
    uses: ['Comunicación', 'Colaboración'],
    accentColor: Color(0xFF4A154B),
  ),
  'figma': SkillDetail(
    categoryEs: 'Diseño de interfaces',
    categoryEn: 'Interface design',
    descEs: 'Herramienta colaborativa de diseño para crear interfaces y prototipos interactivos.',
    descEn: 'Collaborative design tool for creating interfaces and interactive prototypes.',
    uses: ['UI/UX', 'Prototipado', 'Design Systems'],
    accentColor: Color(0xFFF24E1E),
  ),
  'scrum': SkillDetail(
    categoryEs: 'Metodología ágil',
    categoryEn: 'Agile methodology',
    descEs: 'Marco de trabajo ágil para entregar valor de forma iterativa en sprints.',
    descEn: 'Agile framework for delivering value iteratively through sprints.',
    uses: ['Equipos ágiles', 'Sprints'],
    accentColor: Color(0xFF0DB7A4),
  ),
  'jira': SkillDetail(
    categoryEs: 'Gestión de proyectos',
    categoryEn: 'Project management',
    descEs: 'Herramienta para planificar y dar seguimiento a tareas con metodologías ágiles.',
    descEn: 'Tool for planning and tracking tasks with agile methodologies.',
    uses: ['Gestión ágil', 'Tickets'],
    accentColor: Color(0xFF0052CC),
  ),
  'trello': SkillDetail(
    categoryEs: 'Gestión de tareas',
    categoryEn: 'Task management',
    descEs: 'Tableros kanban para organizar tareas y flujos de trabajo de forma visual.',
    descEn: 'Kanban boards for visually organizing tasks and workflows.',
    uses: ['Kanban', 'Organización'],
    accentColor: Color(0xFF0052CC),
  ),
  'officce365': SkillDetail(
    categoryEs: 'Suite de oficina',
    categoryEn: 'Office suite',
    descEs: 'Conjunto de herramientas de productividad de Microsoft para el trabajo diario.',
    descEn: "Microsoft's set of productivity tools for daily work.",
    uses: ['Documentos', 'Hojas de cálculo', 'Presentaciones'],
    accentColor: Color(0xFFD83B01),
  ),
  'office365': SkillDetail(
    categoryEs: 'Suite de oficina',
    categoryEn: 'Office suite',
    descEs: 'Conjunto de herramientas de productividad de Microsoft para el trabajo diario.',
    descEn: "Microsoft's set of productivity tools for daily work.",
    uses: ['Documentos', 'Hojas de cálculo', 'Presentaciones'],
    accentColor: Color(0xFFD83B01),
  ),
  'googleworkspace': SkillDetail(
    categoryEs: 'Suite de oficina',
    categoryEn: 'Office suite',
    descEs: 'Suite colaborativa de Google para documentos, correo y almacenamiento.',
    descEn: "Google's collaborative suite for documents, email and storage.",
    uses: ['Colaboración', 'Documentos', 'Correo'],
    accentColor: Color(0xFF4285F4),
  ),
  'canva': SkillDetail(
    categoryEs: 'Diseño gráfico',
    categoryEn: 'Graphic design',
    descEs: 'Herramienta de diseño accesible para crear gráficos y piezas visuales.',
    descEn: 'Accessible design tool for creating graphics and visual pieces.',
    uses: ['Diseño gráfico', 'Marketing'],
    accentColor: Color(0xFF00C4CC),
  ),
  'photoshop': SkillDetail(
    categoryEs: 'Edición de imágenes',
    categoryEn: 'Image editing',
    descEs: 'Editor de imágenes profesional para retoque y composición visual.',
    descEn: 'Professional image editor for retouching and visual composition.',
    uses: ['Edición', 'Composición'],
    accentColor: Color(0xFF31A8FF),
  ),
};