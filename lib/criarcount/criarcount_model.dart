import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'criarcount_widget.dart' show CriarcountWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CriarcountModel extends FlutterFlowModel<CriarcountWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Email Inválido';
    }
    return null;
  }

  // State field(s) for crieumasenha widget.
  final crieumasenhaKey = GlobalKey();
  FocusNode? crieumasenhaFocusNode;
  TextEditingController? crieumasenhaTextController;
  String? crieumasenhaSelectedOption;
  late bool crieumasenhaVisibility;
  String? Function(BuildContext, String?)? crieumasenhaTextControllerValidator;
  String? _crieumasenhaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Insria uma senha de 9 digitos';
    }
    if (val != crieumasenhaSelectedOption) {
      return 'Please choose an option from the dropdown';
    }
    if (val.length < 9) {
      return 'Requires at least 9 characters.';
    }
    if (val.length > 9) {
      return 'Maximum 9 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for confirmesuasenha widget.
  final confirmesuasenhaKey = GlobalKey();
  FocusNode? confirmesuasenhaFocusNode;
  TextEditingController? confirmesuasenhaTextController;
  String? confirmesuasenhaSelectedOption;
  late bool confirmesuasenhaVisibility;
  String? Function(BuildContext, String?)?
      confirmesuasenhaTextControllerValidator;
  String? _confirmesuasenhaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    if (val != confirmesuasenhaSelectedOption) {
      return 'Please choose an option from the dropdown';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    emailTextControllerValidator = _emailTextControllerValidator;
    crieumasenhaVisibility = false;
    crieumasenhaTextControllerValidator = _crieumasenhaTextControllerValidator;
    confirmesuasenhaVisibility = false;
    confirmesuasenhaTextControllerValidator =
        _confirmesuasenhaTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    crieumasenhaFocusNode?.dispose();

    confirmesuasenhaFocusNode?.dispose();
  }
}
