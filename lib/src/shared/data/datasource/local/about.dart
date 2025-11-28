import 'package:flutter_dotenv/flutter_dotenv.dart';

Map<String, dynamic> aboutData = {
  "name": dotenv.env['REAL_NAME'] ?? '',
  "location": dotenv.env['LOCATION'] ?? '',
  "location_link": dotenv.env['LOCATION_LINK'] ?? '',
  "years": 3,
  "projects": 10,
};
