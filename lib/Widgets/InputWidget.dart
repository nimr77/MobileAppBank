import 'package:flutter/material.dart';

class InputWidget {
  static bool _showPassword = true;

  ///This is Text Used to show
  ///[Note] this contain a [validatorFunctions] which are the list of validator for this
  ///input box beside there is prefix Icon
  static Widget formInputBox(
    TextEditingController Controler_,
    Text_Lable, {
    TextInputType TypeOFKeyBorad = TextInputType.text,
    bool Enabl = true,
    List<bool> validatorFunctions(String value),
    IconData myIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: Enabl,
        keyboardType: TypeOFKeyBorad,
        controller: Controler_,
        validator: (Text) {
          if (TypeOFKeyBorad == TextInputType.emailAddress) {
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(Text);
            if (!emailValid) {
              return "Error in this field";
            }
          }
          if (Text.isEmpty || 60 < Text.length) {
            return "Error in this field";
          }
          try {
            if (validatorFunctions(Text).length > 0) {
              for (bool val in validatorFunctions(Text)) {
                if (val == false) return "Error in this field";
              }
            }
          } catch (e) {
            // print(e);
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.white)),
            labelText: Text_Lable,
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: myIcon != null ? Icon(myIcon) : null,
            errorStyle: TextStyle(color: Colors.redAccent)),
      ),
    );
  }

  ///This is Text Used to OPT
  ///[Note] the second password is for testing if two passwords are matched
//  static Widget formPasswordBox(Controler_, Text_Lable,
//      {TextEditingController secondPassword}) {
//    return StatefulBuilder(builder: (BuildContext context, Stater) {
//      return Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: TextFormField(
//          obscureText: _showPassword,
//          controller: Controler_,
//          validator: (Text) {
//            if (12 < Text.length || Text.length < 6) {
//              return MyLanguage.textError1;
//            }
//            if (Text.isEmpty) {
//              return "الحقل غير صحيح";
//            }
//            if (secondPassword != null) {
//              if (secondPassword.text != Text) {
//                return MyLanguage.passwordsError;
//              }
//            }
//            return null;
//          },
//          decoration: InputDecoration(
//            contentPadding: EdgeInsets.all(20),
//            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//            labelText: Text_Lable,
//            errorStyle: TextStyle(color: Colors.redAccent),
//            prefixIcon: IconButton(
//                icon: Icon(Icons.remove_red_eye),
//                onPressed: () {
//                  Stater(() {
//                    _showPassword = !_showPassword;
//                  });
//                }),
//          ),
//        ),
//      );
//    });
}

class MyInputWidget {
  bool valide = false;
  bool isValide = true;

  ///This is for validating the text input
  String _validateText(
      String Text, List<String Function(String value)> validatorFunctions,
      {TextInputType TypeOFKeyBorad = TextInputType.text}) {
    if (TypeOFKeyBorad == TextInputType.emailAddress) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(Text);
      if (!emailValid) {
        isValide = false;
        return "Error in this field";
      }
    }
    if (Text.isEmpty || 160 < Text.length) {
      isValide = false;
      return "Error in this field";
    }
    try {
      if (validatorFunctions.length > 0 && validatorFunctions != null) {
        for (var fun in validatorFunctions) {
          var val = fun(Text);
          if (val != null) {
            isValide = false;
            return val;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    isValide = true;
    return null;
  }

  ///This is Text Used to show
  ///[Note] this contain a [validatorFunctions] which are the list of validator for this
  ///input box beside there is prefix Icon
  Widget formInputBox(
      // ignore: non_constant_identifier_names
      TextEditingController Controler_,
      Text_Lable,
      {TextInputType TypeOFKeyBorad = TextInputType.text,
      bool Enabl = true,
      List<String Function(String value)> validatorFunctions,
      IconData myIcon,
      List<String> autoFillHints,
      bool outline = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: Enabl,
        autofillHints: autoFillHints,
        keyboardType: TypeOFKeyBorad,
        controller: Controler_,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            border: outline
                ? OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                : UnderlineInputBorder(),
            labelText: Text_Lable,
            errorText: valide
                ? _validateText(Controler_.text, validatorFunctions,
                    TypeOFKeyBorad: TypeOFKeyBorad)
                : null,
            prefixIcon: myIcon != null ? Icon(myIcon) : null,
            errorStyle: TextStyle(color: Colors.redAccent)),
      ),
    );
  }

  ///This is Text Used to show
  ///[Note] this contain a [validatorFunctions] which are the list of validator for this
  ///input box beside there is prefix Icon
  static Widget formInputBoxStand(
      // ignore: non_constant_identifier_names
      TextEditingController Controler_,
      Text_Lable,
      {TextInputType typeOfKeyborad = TextInputType.text,
      bool Enabl = true,
      List<String Function(String value)> validatorFunctions,
      IconData myIcon,
      List<String> autoFillHints,
      bool outline = true,
      String textHint,
      Function(String) onSubmit}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: Enabl,
        autofillHints: autoFillHints,
        keyboardType: typeOfKeyborad,
        controller: Controler_,
        onFieldSubmitted: onSubmit,
        autovalidate: typeOfKeyborad == TextInputType.number,
        validator: (str) {
          if (typeOfKeyborad == TextInputType.number) {
            if (str.isEmpty) return null;
            try {
              double.parse(str);
              return null;
            } catch (e) {
              return "Error in this field";
            }
          } else if (typeOfKeyborad == TextInputType.emailAddress) {
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(str);
            if (!emailValid) {
              return "Error in this field";
            }
          }
          if (str.isEmpty || 160 < str.length) {
            return "Error in this field";
          }
          try {
            if (validatorFunctions.length > 0 && validatorFunctions != null) {
              for (var fun in validatorFunctions) {
                var val = fun(str);
                if (val != null) {
                  return val;
                }
              }
            }
          } catch (e) {
            print(e);
            return null;
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            border: outline
                ? OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                : UnderlineInputBorder(),
            labelText: Text_Lable,
            hintText: textHint,
            prefixIcon: myIcon != null ? Icon(myIcon) : null,
            errorStyle: TextStyle(color: Colors.redAccent)),
      ),
    );
  }

  ///This is Text Used to OPT
  ///[Note] the second password is for testing if two passwords are matched
  static Widget formPasswordBox(Controler_, Text_Lable,
      {TextEditingController secondPassword}) {
    bool _showPassword = true;

    return StatefulBuilder(builder: (BuildContext context, Stater) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          obscureText: _showPassword,
          controller: Controler_,
          validator: (Text) {
            if (12 < Text.length || Text.length < 6) {
              return "Error in this field";
            }
            if (Text.isEmpty) {
              return "Error in this field";
            }
            if (secondPassword != null) {
              if (secondPassword.text != Text) {
                return "Error in this field";
              }
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            labelText: Text_Lable,
            errorStyle: TextStyle(color: Colors.redAccent),
            prefixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  Stater(() {
                    _showPassword = !_showPassword;
                  });
                }),
          ),
        ),
      );
    });
  }
}
