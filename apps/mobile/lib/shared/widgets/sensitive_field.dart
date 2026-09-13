import 'package:flutter/material.dart';

class SensitiveField extends StatefulWidget {
  const SensitiveField({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  State<SensitiveField> createState() => _SensitiveFieldState();
}

class _SensitiveFieldState extends State<SensitiveField> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      container: true,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: Semantics(
            label: _isRevealed ? '隐藏 ${widget.label}' : '显示 ${widget.label}',
            button: true,
            child: IconButton(
              onPressed: () => setState(() => _isRevealed = !_isRevealed),
              icon: Icon(
                _isRevealed
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        ),
        child: Text(
          _isRevealed ? widget.value : '••••••••••••',
          style: const TextStyle(fontFamily: 'monospace'),
        ),
      ),
    );
  }
}
