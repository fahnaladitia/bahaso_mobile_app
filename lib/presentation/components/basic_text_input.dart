import 'package:flutter/material.dart';

class BasicTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final String? Function(String?)? validator;

  const BasicTextInput({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.validator,
  });

  @override
  State<BasicTextInput> createState() => _BasicTextInputState();
}

class _BasicTextInputState extends State<BasicTextInput> {
  bool isVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        TextFormField(
          controller: widget.controller,
          readOnly: widget.readOnly,
          style: Theme.of(context).textTheme.bodyLarge,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFB0B0B0)),
            fillColor: const Color(0xFFFBFBFB),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFD6E4EC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFD6E4EC), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFD6E4EC)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFD6E4EC)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFD6E4EC)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFD6E4EC)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisibility = !isVisibility;
                      });
                    },
                    icon: isVisibility ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  )
                : null,
          ),
          obscureText: widget.obscureText ? !isVisibility : false,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
        ),
      ],
    );
  }
}
