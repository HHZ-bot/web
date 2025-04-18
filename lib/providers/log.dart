// lib/utils/log.dart
import 'package:logging/logging.dart';

class Log {
  /// 初始化日志系统（建议在 main() 里调用一次）
  static void init({Level level = Level.ALL}) {
    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      final time = record.time.toIso8601String();
      final tag = record.loggerName;
      final msg = record.message;
      final level = record.level.name;
      print('[$level] $time | $tag → $msg');
    });
  }

  /// 创建带 tag 的 Logger（推荐每个页面或模块使用独立 tag）
  static Logger withTag(String tag) => Logger(tag);
}
