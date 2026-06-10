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
          "With the goal of presenting an improvement to interbank mobile payments in Venezuela, I was selected through a theoretical proposal from among more than 40 teams to participate in the final. The finalists had to develop a prototype in Figma and perform a live pitch to defend the proposal initially made.",
      "es":
          "Con el objetivo de presentar una mejora en los pagos móviles interbancarios en Venezuela, fui seleccionado mediante una propuesta teórica entre más de 40 equipos para participar en la final. Los finalistas tuvieron que desarrollar un prototipo en Figma y presentar una presentación en vivo para defender la propuesta inicial.",
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
          "With the goal of presenting an improvement to interbank mobile payments in Venezuela, I was selected through a theoretical proposal from among more than 40 teams to participate in the final. The finalists had to develop a prototype in Figma and perform a live pitch to defend the proposal initially made.",
      "es":
          "Con el objetivo de presentar una mejora en los pagos móviles interbancarios en Venezuela, fui seleccionado mediante una propuesta teórica entre más de 40 equipos para participar en la final. Los finalistas tuvieron que desarrollar un prototipo en Figma y presentar una presentación en vivo para defender la propuesta inicial.",
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
          "With the goal of presenting an improvement to interbank mobile payments in Venezuela, I was selected through a theoretical proposal from among more than 40 teams to participate in the final. The finalists had to develop a prototype in Figma and perform a live pitch to defend the proposal initially made.",
      "es":
          "Con el objetivo de presentar una mejora en los pagos móviles interbancarios en Venezuela, fui seleccionado mediante una propuesta teórica entre más de 40 equipos para participar en la final. Los finalistas tuvieron que desarrollar un prototipo en Figma y presentar una presentación en vivo para defender la propuesta inicial.",
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
          "With the goal of presenting an improvement to interbank mobile payments in Venezuela, I was selected through a theoretical proposal from among more than 40 teams to participate in the final. The finalists had to develop a prototype in Figma and perform a live pitch to defend the proposal initially made.",
      "es":
          "Con el objetivo de presentar una mejora en los pagos móviles interbancarios en Venezuela, fui seleccionado mediante una propuesta teórica entre más de 40 equipos para participar en la final. Los finalistas tuvieron que desarrollar un prototipo en Figma y presentar una presentación en vivo para defender la propuesta inicial.",
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
          "My responsibilities include managing client discussions about the features their project will have, as well as its architectural design and efficient implementation in the mobile app and backend.",
      "es":
          "Mis responsabilidades incluyen gestionar las discusiones con los clientes sobre las características que tendrá su proyecto, así como su diseño arquitectónico y su implementación eficiente en la aplicación móvil y el backend.",
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
          "My responsibilities included implementing methods in a microservices system that communicated with each other and sent information via an API to a mobile application. Trello was used to organize the tasks, and Scrum was used to estimate the time it would take to release each feature.",
      "es":
          "Mis responsabilidades incluían la implementación de métodos en un sistema de microservicios que se comunicaban entre sí y enviaban información mediante una API a una aplicación móvil. Se utilizó Trello para organizar las tareas y Scrum para estimar el tiempo de lanzamiento de cada funcionalidad.",
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
          "My responsibilities included implementing methods in a microservices system that communicated with each other, developed using Spring and PostgreSQL. The team was dedicated exclusively to developing the company's main product. We used the Agile Scrum methodology for organization and uploaded tasks to Jira.",
      "es":
          "Mis responsabilidades incluían la implementación de métodos en un sistema de microservicios que se comunicaban entre sí, desarrollado con Spring y PostgreSQL. El equipo se dedicó exclusivamente al desarrollo del producto principal de la empresa. Utilizamos la metodología Agile Scrum para la organización y subimos las tareas a Jira.",
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
