import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Util/GeneralUtil.dart';

class MyButtons {
  static double _redu = 25;

  ///this a simple Button with [TextStyle] that takes it size from the text length,
  ///this Button Contains [OutlineInputBorder] with [borderRadius] that equils [_redu] = [25]
  ///and it contain future loador
  static Widget simpleActionButton(
      Future Function() onPressd, String title, BuildContext context,
      {Color myColor = Colors.amber,
      double heightFactor = 0.05,
      double widthFactor = 0.1,
      double elevation = 10,
      double textFactor = 0.8,
      Color myTextColor = Colors.white}) {
    double height = MyUtil.getContextHeight(context) * heightFactor;
    double width = MyUtil.getContextWidth(context) * widthFactor;
    bool isLoading = false;
    return StatefulBuilder(builder: (context, stater) {
      return MaterialButton(
        onPressed: () async {
          stater(() {
            isLoading = true;
          });
          await onPressd();

          stater(() {
            isLoading = false;
          });
        },
        color: myColor,
        elevation: elevation,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(_redu)),
        child: Container(
          height: height,
          width: width,
          child: Center(
              child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: !isLoading
                ? Text(
                    title,
                    key: ValueKey<bool>(false),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: myTextColor),
                    textAlign: TextAlign.center,
                    textScaleFactor: textFactor,
                  )
                : CircleAvatar(
                    key: ValueKey<bool>(true),
                    backgroundColor: Colors.transparent,
                    radius: 15,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )),
          )),
        ),
      );
    });
  }

  static Widget simpleActionIconButton(
      Future Function() onPressd, IconData title, BuildContext context,
      {Color myColor = Colors.amber}) {
    bool isLoading = false;
    return StatefulBuilder(builder: (context, stater) {
      return IconButton(
        onPressed: () async {
          stater(() {
            isLoading = true;
          });
          await onPressd();

          stater(() {
            isLoading = false;
          });
        },
        icon: Center(
          child: !isLoading
              ? Icon(
                  title,
                  color: myColor,
                )
              : SpinKitThreeBounce(
                  color: Colors.white,
                ),
        ),
      );
    });
  }

  static Widget simpleButton(
      Function() onPressd, String title, BuildContext context,
      {Color myColor = Colors.amber,
      double heightFactor = 0.05,
      double widthFactor = 0.1,
      double elevation = 10,
      double textFactor = 0.8,
      Color myTextColor = Colors.white,
      double redu = 5}) {
    double height = MyUtil.getContextHeight(context) * heightFactor;
    double width = MyUtil.getContextWidth(context) * widthFactor;
    return MaterialButton(
      onPressed: onPressd,
      color: myColor,
      elevation: elevation,
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(redu)),
      child: Container(
        height: height,
        width: width,
        child: Center(
            child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: myTextColor),
          textAlign: TextAlign.center,
          textScaleFactor: textFactor,
        )),
      ),
    );
  }
}
