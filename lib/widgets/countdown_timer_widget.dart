import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/screen_until.dart';
import '../widgets/global_timer_manager.dart';
import '../providers/theme_manager.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;
  final String? customText; // 可选的自定义文本参数

  const CountdownTimer({super.key, required this.endTime, this.customText});

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late String _timeLeft = '';
  late String _taskId;

  @override
  void initState() {
    super.initState();
    _taskId = 'countdown_${widget.endTime.toIso8601String()}';

    // 启动全局定时器并添加任务
    GlobalTimerManager.shared.addOneTimeTask(
        _taskId, const Duration(seconds: 1), _updateTimeLeft,
        totalRuns: widget.endTime.difference(DateTime.now()).inSeconds);
  }

  // 更新倒计时显示
  void _updateTimeLeft() {
    final remainingTime = widget.endTime.difference(DateTime.now());

    if (remainingTime.isNegative) {
      // 在 setState 前检查 mounted
      if (mounted) {
        setState(() {
          _timeLeft = context.tr('payment.timeover');
        });
      }
    } else {
      // 在 setState 前检查 mounted
      if (mounted) {
        setState(() {
          _timeLeft = _formatTime(remainingTime);
        });
      }
    }
  }

  late String translatedLabel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translatedLabel = context.tr('payment.day');
  }

  // 格式化时间
  String _formatTime(Duration duration) {
    String days =
        duration.inDays > 0 ? '${duration.inDays} $translatedLabel  ' : '';

    String hours =
        '${duration.inHours.remainder(24).toString().padLeft(2, '0')}: ';
    String minutes =
        '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}: ';
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return widget.customText == null
        ? '$days$hours$minutes$seconds'
        : duration.inSeconds.remainder(60).toString().padLeft(1, '0');
  }

  @override
  void dispose() {
    // 移除任务
    GlobalTimerManager.shared.removeTask(_taskId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.customText == null
          ? _timeLeft
          : '$_timeLeft S ${context.tr('signin.close')}',
      style: TextStyle(
        fontSize: ScreenUtil.sp(4.3),
        fontWeight: FontWeight.w700,
        color: ThemeProvider.instance.onPrimaryColor,
      ),
    );
  }
}
