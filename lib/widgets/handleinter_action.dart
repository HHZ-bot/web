import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

void handleInternalAction(String action, BuildContext context) {
  switch (action.trim()) {
    case 'jump_home':
      context.go("/");
      break;
    case 'jump_download':
      context.go("/download");
      break;
    case 'jump_payments':
      context.go("/payments");
      break;

    default:
      debugPrint("未知操作: $action");
  }
}
