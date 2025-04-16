import 'dart:async';

import 'package:flutter/foundation.dart';

class GlobalTimerManager {
  // 单例模式
  static final GlobalTimerManager shared = GlobalTimerManager._internal();

  // 内部构造函数
  GlobalTimerManager._internal();

  Timer? _globalTimer; // 单一的全局定时器
  final Map<String, TimerTask> _tasks = {}; // 存储需要执行的任务
  final Duration _tickInterval = const Duration(seconds: 1); // 定时器间隔
  bool _isRunning = false; // 标记定时器是否在运行

  // 添加一个重复任务到全局定时器
  void addRepeatingTask(String taskId, Duration interval, Function() callback,
      {bool isstop = false}) {
    // 如果任务已存在，返回
    print('当前任务列表: $_tasks');
    print('当前 taskId: $taskId');
    if (_tasks.containsKey(taskId)) {
      print('任务已存在，删除旧任务');
      removeTask(taskId); // 任务已存在，不再重复添加
    }

    // 添加一个新的任务
    _tasks[taskId] =
        TimerTask(taskId, interval, callback, isLooping: true, isstop: false);
    if (kDebugMode) {
      print('添加定时器了: $taskId');
    }

    // 如果全局定时器没有运行，则启动它
    if (!_isRunning) {
      _startGlobalTimer();
    }
  }

  // 添加一次性任务到全局定时器
  void addOneTimeTask(String taskId, Duration interval, Function() callback,
      {int totalRuns = 1}) {
    // 如果任务已存在，停止原任务
    if (_tasks.containsKey(taskId)) {
      removeTask(taskId); // 删除已存在的任务
    }

    // 添加一次性任务
    _tasks[taskId] = TimerTask(
      taskId,
      interval,
      callback,
      isLooping: false,
      remainingRuns: totalRuns,
    );

    // 如果全局定时器没有运行，则启动它
    if (!_isRunning) {
      _startGlobalTimer();
    }
  }

  // 启动全局定时器来处理所有任务
  void _startGlobalTimer() {
    _isRunning = true;
    _globalTimer = Timer.periodic(_tickInterval, _handleTimerTick);
  }

  // 处理每一秒钟的定时器滴答，并检查任务是否需要执行
  void _handleTimerTick(Timer timer) {
    List<String> tasksToRemove = []; // 用于记录需要删除的任务

    // 检查所有任务的执行
    _tasks.forEach((taskId, task) {
      task._elapsedTime += _tickInterval;

      // 如果已用时间超过任务间隔，执行回调并重置已用时间
      if (task._elapsedTime >= task.interval) {
        task.callback();
        task._elapsedTime = Duration.zero; // 重置已用时间

        // 如果是一次性任务，执行后减少剩余次数
        if (!task.isLooping) {
          task.remainingRuns--; // 执行次数减1
          if (task.remainingRuns < 0) {
            tasksToRemove.add(taskId); // 记录需要删除的任务
          }
        } else {
          if (task.isstop == true) {
            tasksToRemove.add(taskId);
          }
        }
      }
    });

    // 删除所有需要删除的任务
    for (var taskId in tasksToRemove) {
      removeTask(taskId); // 执行删除任务
    }

    // 如果没有任务剩余，停止定时器
    if (_tasks.isEmpty) {
      stop();
    }
  }

  // 设置停止任务
  void setStopTask(String taskId) {
    if (_tasks.containsKey(taskId)) {
      _tasks[taskId]?.isstop = true;
      print('任务 $taskId 已被停止');
    } else {
      print('任务 $taskId 不存在');
    }
  }

  // 停止全局定时器
  void stop() {
    if (_isRunning) {
      _globalTimer?.cancel();
      _globalTimer = null;
      _isRunning = false;
    }
  }

  // 移除一个任务
  void removeTask(String taskId) {
    _tasks.remove(taskId); // 删除任务

    // 如果没有任务了，停止全局定时器
    if (_tasks.isEmpty && _isRunning) {
      stop();
    }
  }
}

// 定时任务模型，用于存储每个任务的间隔和回调
class TimerTask {
  final String taskId;
  final Duration interval; // 任务的间隔（例如：Duration(seconds: 5)）
  final Function() callback; // 任务的回调函数
  Duration _elapsedTime = Duration.zero; // 从上次执行到现在的已用时间
  final bool isLooping; // 是否是循环任务
  late bool isstop; // 是否是循环任务
  int remainingRuns; // 剩余执行次数

  TimerTask(this.taskId, this.interval, this.callback,
      {this.isLooping = false, this.remainingRuns = 1, this.isstop = false});

  // 取消任务
  void cancel() {
    _elapsedTime = Duration.zero;
  }
}
