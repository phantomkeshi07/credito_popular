import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dados_cadastrais_widget.dart' show DadosCadastraisWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class DadosCadastraisModel extends FlutterFlowModel<DadosCadastraisWidget> {
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  String? _nomeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(val)) {
      return 'Nome inválido. Use apenas letras e espaços.';
    }
    return null;
  }

  // State field(s) for cpf widget.
  FocusNode? cpfFocusNode;
  TextEditingController? cpfTextController;
  String? Function(BuildContext, String?)? cpfTextControllerValidator;
  String? _cpfTextControllerValidator(BuildContext context, String? val) {
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

  // State field(s) for telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  String? _telefoneTextControllerValidator(BuildContext context, String? val) {
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

  @override
  void initState(BuildContext context) {
    nomeTextControllerValidator = _nomeTextControllerValidator;
    cpfTextControllerValidator = _cpfTextControllerValidator;
    telefoneTextControllerValidator = _telefoneTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();
    cpfFocusNode?.dispose();
    cpfTextController?.dispose();
    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();
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

  // Função para verificar se CPF ou telefone já existem no banco de dados
  Future<bool> isCpfOrPhoneNumberExists(String cpf, String phone) async {
    print("Verificando existência de CPF e telefone");
    final cpfQuery = await FirebaseFirestore.instance
        .collection('user')
        .where('cpf', isEqualTo: cpf)
        .get();
    if (cpfQuery.docs.isNotEmpty) {
      print("CPF já cadastrado");
      return true;
    }
    final phoneQuery = await FirebaseFirestore.instance
        .collection('user')
        .where('phone_number', isEqualTo: phone)
        .get();
    if (phoneQuery.docs.isNotEmpty) {
      print("Telefone já cadastrado");
      return true;
    }
    print("CPF e telefone disponíveis");
    return false;
  }
}
