// Experience entries — newest first.
//
// Fields:
//   company      – primary company name  (use when single company)
//   company_url  – website for the company (nullable)
//   companies    – list of {name, url} for multi-company entries (use instead of company)
//   role         – position held (nullable — hackathons & self-learning have none)
//   event        – competition / event name (hackathons only, nullable)
//   event_urls   – list of URLs for the event page(s) (nullable)
//   category     – "Full Time" | "Part Time" | "Industrial Project" | "Hackathon"
//   description  – {en, es} localized text

List<Map<String, dynamic>> experience = [
  {
    "init_time": "04/2026",
    "end_time": "",
    "company": "Estei Turismo",
    "company_url": "https://estei.app",
    "image": "assets/images/exp_estei.jpeg",
    "role": "Software Engineer",
    "event": null,
    "event_urls": null,
    "description": {
      "en":
          "Maintaining the mobile application built with Flutter, BLoC, FCM, and GoRouter. Building the Estei 2.0 backend using Node.js, NestJS, GraphQL, and MongoDB. Following an Agile SCRUM methodology with an AI-First philosophy and TDD development flow.",
      "es":
          "Mantenimiento de la aplicación móvil desarrollada en Flutter, BLoC, FCM y GoRouter. Levantamiento del Backend Estei 2.0 usando Node.js, NestJS, GraphQL y MongoDB. Metodología de trabajo Ágil: SCRUM con filosofía AI-First y desarrollo mediante flujo TDD.",
    },
    "category": "Full Time",
  },
  {
    "init_time": "03/2026",
    "end_time": "05/2026",
    "companies": [
      {"name": "EY Venezuela", "url": "https://www.ey.com/es_ve", "image": "assets/images/exp_ey.jpeg"},
      {"name": "Kurius", "url": "https://www.kuriosedu.com", "image": "assets/images/exp_kurius.jpeg"},
    ],
    "role": null,
    "event": "Reto Inspira VE",
    "event_urls": [
      "https://www.innoveytion-summit.com/reto-innovation-university",
      "https://www.kuriosedu.com/inspira",
    ],
    "description": {
      "en":
          "Selected as a finalist in the InspiraVE challenge by EY Venezuela and Kurius. I co-developed Neopago, a product designed to boost payment flows and drive sales growth for small businesses in Venezuela. The solution was pitched live to an investor jury, defending both the business value and technical vision behind it.",
      "es":
          "Seleccionado como finalista en el Reto InspiraVE de EY Venezuela y Kurius. Co-desarrollé Neopago, un producto diseñado para aumentar el flujo de cobros e impulsar las ventas de los pequeños comercios en Venezuela. La solución fue presentada en vivo ante un jurado de inversionistas, defendiendo tanto el valor de negocio como la visión técnica detrás de ella.",
    },
    "category": "Hackathon",
    "cert_link": "https://drive.google.com/file/d/1OyELk8PCuFIH7GQxzApphuzq8CDOfOZL/view?usp=drive_link",
  },
  {
    "init_time": "12/2025",
    "end_time": "",
    "company": "Banking Technologies Consulting",
    "company_url": "https://bankingtech.com.ve",
    "image": "assets/images/exp_btc.jpeg",
    "role": "Software Engineer",
    "event": null,
    "event_urls": null,
    "description": {
      "en":
          "Implemented a YOLO-trained Machine Learning model in a KYC system, enhanced with image processing using OpenCV2, EasyOCR, and Torch. Built liveness detection with Mediapipe, OpenCV2, and Deepface for identity similarity and gesture verification. Developed a multitenant internal CRM with JWT access control using Next.js and Tanstack Query.",
      "es":
          "Implementación de un modelo de Machine Learning entrenado en YOLO dentro de un sistema KYC, mejorado con tratamiento de imágenes usando OpenCV2, EasyOCR y Torch. Detección de pruebas de vida mediante Mediapipe, OpenCV2 y Deepface para determinar similitud de identidad y gestos. Desarrollo de un CRM multitenant interno con control de acceso JWT en Next.js y Tanstack Query.",
    },
    "category": "Full Time",
  },
  {
    "init_time": "06/2025",
    "end_time": "10/2025",
    "company": "Suiche7B",
    "company_url": "https://suiche7b.com.ve",
    "image": "assets/images/exp_suiche_7b.png",
    "role": null,
    "event": "Desafío S7B",
    "event_urls": ["https://suiche7b.com.ve/?p=29269"],
    "description": {
      "en":
          "Finalist in the second edition of Desafío S7B. With the goal of reimagining interbank mobile payments in Venezuela, my proposal stood out among more than 40 competing teams and secured a spot in the final. As a finalist, I built a high-fidelity Figma prototype and delivered a live pitch to defend the solution's impact and viability.",
      "es":
          "Finalista en la segunda edición del Desafío S7B. Con el objetivo de reinventar los pagos móviles interbancarios en Venezuela, mi propuesta destacó entre más de 40 equipos competidores y logró un lugar en la final. Como finalista, desarrollé un prototipo de alta fidelidad en Figma y realicé una presentación en vivo para defender el impacto y la viabilidad de la solución.",
    },
    "category": "Hackathon",
    "cert_link": "https://drive.google.com/file/d/1OyELk8PCuFIH7GQxzApphuzq8CDOfOZL/view?usp=drive_link",
  },
  {
    "init_time": "04/2025",
    "end_time": "04/2026",
    "company": "Flembee Technologies",
    "company_url": "https://flembee.com",
    "image": "assets/images/exp_flembee.jpeg",
    "role": "Fullstack Developer",
    "event": null,
    "event_urls": null,
    "description": {
      "en":
          "Developed mobile applications using Clean Architecture and Flutter, including SocketIO and FCM integration across multiple projects such as Kudo App and Padel Now. Implemented JWT client-side access control and state management with BLoC and GetX. Built backend endpoints with Node.js and integrated Supabase and MongoDB databases.",
      "es":
          "Desarrollo de aplicaciones móviles con Clean Architecture y Flutter incluyendo la implementación de SocketIO y FCM en proyectos como Kudo App y Padel Now. Control de acceso JWT en cliente y manejo de estados con BLoC y GetX en Flutter. Implementación de endpoints en Node.js y bases de datos Supabase y MongoDB.",
    },
    "category": "Full Time",
  },
  {
    "init_time": "03/2024",
    "end_time": "03/2025",
    "company": "Hospital J.M. de los Rios",
    "company_url": "https://hospitaljmdelosrios.org.ve/?i=1",
    "image": "assets/images/exp_jm.jpg",
    "role": "Fullstack Developer",
    "event": null,
    "event_urls": null,
    "description": {
      "en":
          "Led the full-stack development of an intranet application built to empower doctors to create, review, and manage clinical cases end-to-end. The engagement started with a structured requirements gathering process that shaped the use cases and drove the project roadmap, managed throughout on a Trello board.\n\nArchitected and built a Spring Boot microservices system from scratch — covering the full clinical domain flow — using Feign for inter-service communication and JPARepository as the ORM. The relational database was designed from the ground up: modeled in diagrams.net, set up in PGAdmin4, and backed by PostgreSQL. JWT-based access control was implemented across the entire system.\n\nOn the frontend, a Figma prototype was designed and validated before a single line of code was written, then brought to life as a Flutter application built with Clean Architecture and the Cubit pattern for state management, connected to the backend via REST API. The project earned Honorable Mention as the capstone project of my Systems Engineering degree.",
      "es":
          "Lideré el desarrollo fullstack de una aplicación intranet diseñada para que los doctores pudieran crear, revisar y gestionar casos clínicos de extremo a extremo. El proyecto arrancó con un levantamiento de requerimientos estructurado que definió los casos de uso y dio forma al alcance del trabajo, administrado durante todo el ciclo en un tablero de Trello.\n\nArquitecté y levanté desde cero un sistema de microservicios en Spring Boot cubriendo el flujo completo del dominio clínico, utilizando Feign para la comunicación entre servicios y JPARepository como ORM. La base de datos relacional se diseñó desde cero: modelada en diagrams.net, levantada en PGAdmin4 y respaldada en PostgreSQL. El control de acceso JWT fue implementado a lo largo de todo el sistema.\n\nEn el frontend, se diseñó y validó un prototipo en Figma antes de escribir una sola línea de código, que luego se materializó como una aplicación Flutter construida con Clean Architecture y el patrón Cubit para el manejo de estados, conectada al backend vía REST API. El proyecto obtuvo Mención Honorífica como proyecto de grado de la carrera de Ingeniería de Sistemas.",
    },
    "category": "Industrial Project",
    "thesis_link": "https://unimet.ent.sirsi.net/client/es_ES/default/search/detailnonmodal/ent:\$002f\$002fSD_ILS\$002f0\$002fSD_ILS:137932/one",
  },
  {
    "init_time": "06/2023",
    "end_time": "12/2023",
    "company": "En la Parada",
    "company_url": "https://en-la-parada-landing.lovable.app",
    "image": "assets/images/exp_enlaparada.jpg",
    "role": "Backend Developer",
    "event": null,
    "event_urls": null,
    "description": {
      "en":
          "Contributed to the backend of a transportation platform by developing and personally standing up multiple Spring Boot microservices, covering the full domain flow from users and passengers to operations. Used JPARepository as the ORM and managed the PostgreSQL database through PGAdmin4, optimizing schemas to strengthen table relationships and improve data integrity across services. JWT-based access control was implemented to secure the system endpoints.\n\nDelivered under an Agile SCRUM workflow managed in Jira, with Bitbucket for version control. This role deepened my understanding of microservices architecture — its advantages over monoliths and how to evaluate when each approach is the right fit.",
      "es":
          "Contribuí al backend de una plataforma de transporte desarrollando y levantando personalmente múltiples microservicios en Spring Boot, cubriendo el flujo completo del dominio desde usuarios y pasajeros hasta operaciones. Utilicé JPARepository como ORM y administré la base de datos PostgreSQL a través de PGAdmin4, optimizando los esquemas para fortalecer las relaciones entre tablas y mejorar la integridad de los datos entre servicios. El control de acceso JWT fue implementado para asegurar los endpoints del sistema.\n\nTrabajé bajo una metodología Ágil SCRUM administrada en Jira, con Bitbucket para el control de versiones. Este rol consolidó mi comprensión de la arquitectura de microservicios — sus ventajas frente al monolito y cómo evaluar cuándo aplicar cada enfoque.",
    },
    "category": "Part Time",
  },
  {
    "init_time": "01/2023",
    "end_time": null,
    "company": "Self - Learning",
    "company_url": null,
    "role": "Incremento continuo de conocimientos",
    "event": null,
    "event_urls": null,
    "description": {
      "en":
          "Time for general education where I learn about frameworks, programming languages, architecture, and more — all while completing my Systems Engineering degree in parallel.",
      "es":
          "Tiempo para la educación general donde aprendo sobre frameworks, lenguajes de programación, arquitectura y más — todo mientras completaba en paralelo mi carrera de Ingeniería de Sistemas.",
    },
    "category": "Full Time",
  },
];
