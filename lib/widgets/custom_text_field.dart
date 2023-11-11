import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? type;
  final IconData? prefix;
  final bool? enable;
  final bool password;
  final String? label;
  final Function? validateFunc;
  final double radius;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.type,
    this.prefix,
    this.enable,
    this.password = false,
    this.label,
    this.validateFunc,
    this.radius = 10.0,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscurePassword = false;

  @override
  void initState() {
    super.initState();
    obscurePassword = widget.password;
  }

  void changePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.type,
        enabled: widget.enable,
        obscureText: obscurePassword,
        textAlignVertical: TextAlignVertical.center,
        validator: (text) {
          if (widget.validateFunc != null) return widget.validateFunc!(text);
          return null;
        },
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.prefix != null
              ? Icon(
                  widget.prefix,
                )
              : null,
          suffixIcon: widget.password
              ? IconButton(
                  onPressed: changePasswordVisibility,
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
      ),
    );
  }
}
