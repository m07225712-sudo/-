import 'package:drift/drift.dart';
import 'package:drift/web.dart';

DatabaseConnection openDatabaseConnection() {
  return DatabaseConnection(WebDatabase('app'));
}