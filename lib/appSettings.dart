import 'apiWrapperStub.dart'
    if (dart.library.io) 'androidApiWrapper.dart'
    if (dart.library.html) 'webApiWrapper.dart';

class AppSettings {
  static Map<String, Map> files;
  static APIWrapper api = APIWrapper();
  static String filesTheme;
  static String fabTheme;
  static bool error = false;

  static Future<bool> copy(
    String text,
  ) =>
      api.copy(text);

  static Future<void> getSettings() async {
    fabTheme = await api.getString('fabTheme', 'extended');
    filesTheme = await api.getString('filesTheme', 'new');
  }

  static Future<Map<String, dynamic>> getFiles() async {
    if (files == null) {
      Map _ = await api.getFiles();
      if (_.containsKey('error')) {
        error = true;
        return {};
      }
      files = _.cast<String, Map>();
    }
    return files;
  }

  static Future<bool> saveFiles() async {
    if (files == null) return false;
    return await api.saveFiles(files);
  }

  static Future<bool> saveSettings() async {
    return await api.setString('fabTheme', fabTheme) &&
        await api.setString('filesTheme', filesTheme);
  }
}
