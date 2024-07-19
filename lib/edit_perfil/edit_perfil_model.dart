import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'edit_perfil_widget.dart' show EditPerfilWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditPerfilModel extends FlutterFlowModel<EditPerfilWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();

  // State field(s) for SeuNome widget.
  FocusNode? seuNomeFocusNode;
  TextEditingController? seuNomeTextController;
  String? Function(BuildContext, String?)? seuNomeTextControllerValidator;
  String? _seuNomeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(val)) {
      return 'Nome inválido. Use apenas letras e espaços.';
    }
    return null;
  }

  // State field(s) for SeuEmail widget.
  FocusNode? seuEmailFocusNode;
  TextEditingController? seuEmailTextController;
  String? Function(BuildContext, String?)? seuEmailTextControllerValidator;
  String? _seuEmailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(val)) {
      return 'Email inválido.';
    }
    return null;
  }

  // State field(s) for SeuCpf widget.
  FocusNode? seuCpfFocusNode;
  TextEditingController? seuCpfTextController;
  String? Function(BuildContext, String?)? seuCpfTextControllerValidator;
  String? _seuCpfTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }
    if (val.length != 11) {
      return 'CPF deve ter 11 dígitos.';
    }
    if (!RegExp(r'^\d{11}$').hasMatch(val)) {
      return 'CPF inválido. Use apenas números.';
    }
    if (!isValidCPF(val)) {
      return 'CPF inválido.';
    }
    return null;
  }

  // State field(s) for SeuTelefone widget.
  FocusNode? seuTelefoneFocusNode;
  TextEditingController? seuTelefoneTextController;
  String? Function(BuildContext, String?)? seuTelefoneTextControllerValidator;
  String? _seuTelefoneTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }
    if (val.length != 11) {
      return 'Telefone deve ter 11 dígitos.';
    }
    if (!RegExp(r'^\d{11}$').hasMatch(val)) {
      return 'Telefone inválido. Use apenas números.';
    }
    if (!isValidPhoneNumber(val)) {
      return 'Telefone inválido.';
    }
    return null;
  }

  // State field(s) for datadenascimento widget.
  FocusNode? datadenascimentoFocusNode;
  TextEditingController? datadenascimentoTextController;
  String? Function(BuildContext, String?)?
      datadenascimentoTextControllerValidator;
  String? _datadenascimentoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(val)) {
      return 'Data de nascimento inválida. Use o formato DD/MM/AAAA.';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    seuNomeTextControllerValidator = _seuNomeTextControllerValidator;
    seuEmailTextControllerValidator = _seuEmailTextControllerValidator;
    seuCpfTextControllerValidator = _seuCpfTextControllerValidator;
    seuTelefoneTextControllerValidator = _seuTelefoneTextControllerValidator;
    datadenascimentoTextControllerValidator =
        _datadenascimentoTextControllerValidator;
  }

  @override
  void dispose() {
    seuNomeFocusNode?.dispose();
    seuNomeTextController?.dispose();
    seuEmailFocusNode?.dispose();
    seuEmailTextController?.dispose();
    seuCpfFocusNode?.dispose();
    seuCpfTextController?.dispose();
    seuTelefoneFocusNode?.dispose();
    seuTelefoneTextController?.dispose();
    datadenascimentoFocusNode?.dispose();
    datadenascimentoTextController?.dispose();
  }

  // Função para validar CPF
  bool isValidCPF(String cpf) {
    if (cpf.length != 11 || RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
      return false;
    }
    List<int> numbers = cpf.split('').map((d) => int.parse(d)).toList();
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += numbers[i] * (10 - i);
    }
    int firstCheckDigit = (sum * 10) % 11;
    if (firstCheckDigit == 10) {
      firstCheckDigit = 0;
    }
    if (firstCheckDigit != numbers[9]) {
      return false;
    }
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += numbers[i] * (11 - i);
    }
    int secondCheckDigit = (sum * 10) % 11;
    if (secondCheckDigit == 10) {
      secondCheckDigit = 0;
    }
    return secondCheckDigit == numbers[10];
  }

  // Função para validar número de telefone brasileiro
  bool isValidPhoneNumber(String phone) {
    return RegExp(r'^\d{2}[9]\d{8}$').hasMatch(phone);
  }
}
