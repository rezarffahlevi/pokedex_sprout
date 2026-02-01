import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  static bool isLoadingPopupShown = false;
  static void showLoadingPopup(BuildContext? context, {isVisible = true}) {
    if (isLoadingPopupShown) return;

    isLoadingPopupShown = true;

    if (isVisible) {
      showGeneralDialog(
        context: context!,
        barrierColor: Colors.black12.withOpacity(0.2),
        barrierDismissible: false,
        barrierLabel: "Dialog",
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return PopScope(
            canPop: false,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MyLoading(),
              ),
            ),
          );
        },
      );
    } else {
      showGeneralDialog(
        context: context!,
        barrierColor: Colors.black12.withOpacity(0.01),
        barrierDismissible: false,
        barrierLabel: "Dialog",
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return PopScope(canPop: false, child: Container());
        },
      );
    }
  }

  static void dismissLoadingPopup(BuildContext? context) {
    if (!isLoadingPopupShown) return;

    isLoadingPopupShown = false;
    Navigator.pop(context!);
  }
}
