import 'package:flutter/foundation.dart';

const String devBaseUrl = "http://localhost:3000";
const String prodBaseUrl = "https://your-backend.up.railway.app";

String getBaseUrl() {
  return kReleaseMode ? prodBaseUrl : devBaseUrl;
}
