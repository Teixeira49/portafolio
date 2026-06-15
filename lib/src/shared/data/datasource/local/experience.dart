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
          "Participated in the second edition of the InspiraVE challenge organized by EY Venezuela and Kurius, an innovation competition where teams proposed and developed tech solutions to real business problems.",
      "es":
          "Participación en la segunda edición del Reto InspiraVE organizado por EY Venezuela y Kurius, un concurso de innovación donde los equipos propusieron y desarrollaron soluciones tecnológicas a problemas empresariales reales.",
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
          "Finalist in the second edition of Desafío S7B. With the goal of presenting an improvement to interbank mobile payments in Venezuela, I was selected through a theoretical proposal from among more than 40 teams to participate in the final. Finalists had to develop a Figma prototype and perform a live pitch to defend the proposal.",
      "es":
          "Finalista en la segunda edición del Desafío S7B. Con el objetivo de presentar una mejora en los pagos móviles interbancarios en Venezuela, fui seleccionado mediante una propuesta teórica entre más de 40 equipos para participar en la final. Los finalistas tuvieron que desarrollar un prototipo en Figma y realizar una presentación en vivo para defender la propuesta.",
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
    "company": "JM Rios",
    "company_url": "https://hospitaljmdelosrios.org.ve/?i=1",
    "image": "assets/images/exp_jm.jpg",
    "role": "Fullstack Developer",
    "event": null,
    "event_urls": null,
    "description": {
      "en":
          "Developed a mobile application with Clean Architecture and Flutter for managing clinical patient records. Designed and implemented Spring Boot microservices with a PostgreSQL database to manage patients, diagnoses, and doctors. The project received Honorable Mention in the Industrial Project evaluation.",
      "es":
          "Desarrollo de aplicación móvil con Clean Architecture y Flutter para la gestión de historias clínicas de pacientes. Diseño e implementación de microservicios en Spring Boot y base de datos PostgreSQL para gestionar pacientes, diagnósticos y doctores. El proyecto recibió Mención Honorífica en la evaluación del Proyecto Industrial.",
    },
    "category": "Industrial Project",
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
          "Built Spring Boot microservices connected to a PostgreSQL database to manage tickets, passengers, buses, and application users. Worked within an Agile SCRUM methodology.",
      "es":
          "Construcción de microservicios en Spring Boot comunicados a una base de datos PostgreSQL para administrar tickets, pasajeros, autobuses y usuarios de la aplicación. Metodología de trabajo Ágil: SCRUM.",
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
          "Time for general education where I learn about frameworks, programming languages, architecture, and more",
      "es":
          "Tiempo para la educación general donde aprendo sobre frameworks, lenguajes de programación, arquitectura y más",
    },
    "category": "Full Time",
  },
];
