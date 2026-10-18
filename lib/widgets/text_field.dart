import 'package:flutter/material.dart';

enum FieldType {
  fullName,
  email,
  password,
  confirmPassword,
  general,
}

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final FieldType fieldType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.fieldType = FieldType.general,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.fieldType == FieldType.password ||
        widget.fieldType == FieldType.confirmPassword;
  }

  String? _validate(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }

    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.fieldType) {
      case FieldType.fullName:
        if (!RegExp(r'^[А-Яа-яЁёA-Za-z\s]+$').hasMatch(value.trim())) {
          return 'Имя может содержать только буквы и пробелы';
        }
        break;
      case FieldType.email:
        if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(value.trim())) {
          return 'Введите корректный email (пример: имя@домен.ru)';
        }
        break;
      case FieldType.password:
        if (value.trim().length < 6) {
          return 'Пароль не менее 6 символов';
        }
        if (!RegExp(r'[A-Za-zА-Яа-я]').hasMatch(value.trim())) {
          return 'Пароль должен содержать буквы';
        }
        if (!RegExp(r'[0-9]').hasMatch(value.trim())) {
          return 'Пароль должен содержать цифры';
        }
        if (!RegExp(r'[+\-_]').hasMatch(value.trim())) {
          return 'Пароль должен содержать символы: +, _, -';
        }
        break;
      case FieldType.confirmPassword:
        if (value.trim().isEmpty) {
          return 'Поле не может быть пустым';
        }
        break;
      case FieldType.general:
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.nextFocusNode != null
                ? (_) => widget.nextFocusNode!.requestFocus()
                : null,
            obscureText: _obscureText,
            validator: _validate,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              prefixIcon: Icon(widget.icon, color: Colors.grey.shade600),
              suffixIcon: (widget.fieldType == FieldType.password ||
                      widget.fieldType == FieldType.confirmPassword)
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
              errorMaxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}
