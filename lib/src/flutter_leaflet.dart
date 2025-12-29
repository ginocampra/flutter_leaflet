import 'package:flutter/material.dart';

class MeuBotao extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;

  const MeuBotao({
    super.key,
    required this.texto,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(texto),
    );
  }
}
