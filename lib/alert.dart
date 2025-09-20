import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:progress_dialog/progress_dialog.dart';

class Alert {
  static toast(String msg) {
    Get.showSnackbar(GetSnackBar(
      message: msg,
      duration: Duration(seconds: 3),
      isDismissible: true,
    ));
  }

  static Future confirmDialog(
      {required String? message, required VoidCallback onOk}) {
    return Get.dialog(
      // return object of type Dialog
      Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Wrap(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    message ?? "",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.overlayContext!).pop();
                        },
                        child: Container(
                          width: (MediaQuery.of(Get.context!).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'No',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.overlayContext!).pop();
                          onOk();
                        },
                        child: Container(
                          width: (MediaQuery.of(Get.context!).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Yes',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future infoDialog({required String message}) {
    return Get.dialog(
      Dialog(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Directionality(
          // textDirection: AppVar.LANG_CODE == 'ar'?TextDirection.rtl:TextDirection.ltr,
          textDirection: TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(Get.overlayContext!).pop();
                      },
                      child: Container(
                        width: (MediaQuery.of(Get.context!).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Ok',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
