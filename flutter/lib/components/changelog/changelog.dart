import 'package:flutter/services.dart'; // Import flutter/services.dart

class ChangeLog {
  static Future<List<Map<String, dynamic>>> get() async {
    final changelogText =
        await rootBundle.loadString('lib/CHANGELOG.md'); // Load the local file

    return _parseChangelog(changelogText);
  }

  static List<Map<String, dynamic>> _parseChangelog(String changelogText) {
    final List<Map<String, dynamic>> changelogEntries = [];
    final List<String> lines = changelogText.split('\n');

    Map<String, dynamic>? currentEntry;
    String? currentCategory;

    for (String line in lines) {
      if (line.startsWith('## ')) {
        // Start a new version entry
        currentEntry = {
          'version': line.substring(2).trim(),
          'added': [],
          'changed': [],
          'removed': [],
          'fixed': []
        };
        changelogEntries.add(currentEntry);
        currentCategory = null;
      } else if (line.startsWith('### Added')) {
        currentCategory = 'added';
      } else if (line.startsWith('### Changed')) {
        currentCategory = 'changed';
      } else if (line.startsWith('### Removed')) {
        currentCategory = 'removed';
      } else if (line.startsWith('### Fixed')) {
        currentCategory = 'fixed';
      } else if (currentCategory != null && line.startsWith('- ')) {
        currentEntry?[currentCategory]
            ?.add(line.substring(2).trim().replaceAll('*', ''));
      }
    }

    return changelogEntries;
  }
}
