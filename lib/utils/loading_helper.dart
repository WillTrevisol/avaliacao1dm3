import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin LoadingHelper {
  bool loading = false;

  void showLoading(BuildContext context) {
    loading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void hideLoading(BuildContext context) {
    if (loading) {
      context.pop();
    }
    loading = false;
  }
}
