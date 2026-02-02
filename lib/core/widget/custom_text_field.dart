import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/responsiv/risponsive.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String text;
  final Color color;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final double paddingTop;
  final double paddingBtm;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.color = GlobalColor.grayTextField,
    this.paddingTop = 0,
    this.paddingBtm = 0,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil.getHeight(widget.paddingTop),
          left: 16,
          right: 16,
          bottom: ScreenUtil.getHeight(widget.paddingBtm)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '  ${widget.text}',
            style: GlobalTextStyle.body.copyWith(color: GlobalColor.black),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            validator: widget.validator,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              fillColor: widget.color,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: GlobalColor.grayTextField),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: GlobalColor.grayTextField),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: GlobalColor.greenButton),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.red),
              ),
              hintText: widget.hintText,
              hintStyle: GlobalTextStyle.body.copyWith(color: Colors.grey),
              prefixIcon:
                  widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFieldSearch extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String text;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final Color color;
  final double paddingLeft;
  final double paddingRight;
  final double width;
  final double height;

  const CustomTextFieldSearch({
    super.key,
    required this.controller,
    required this.text,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.color = Colors.white,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.width = 269,
    this.height = 52,
  });

  @override
  CustomTextFieldSearchState createState() => CustomTextFieldSearchState();
}

class CustomTextFieldSearchState extends State<CustomTextFieldSearch> {
  late FocusNode _focusNode;
  bool _isTextEmpty = true;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isTextEmpty = widget.controller.text.isEmpty;
    _focusNode.addListener(_onFocusChanged);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {
      _isTextEmpty = widget.controller.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil.getWidth(widget.paddingLeft),
          right: ScreenUtil.getWidth(widget.paddingRight)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil.getHeight(widget.height),
            width: ScreenUtil.getWidth(widget.width ),
            child: TextFormField(
              focusNode: _focusNode,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              validator: widget.validator,
              decoration: InputDecoration(
                fillColor: widget.color,
                filled: true,
                hintText: widget.hintText,
                hintStyle: GlobalTextStyle.body.copyWith(
                  color: GlobalColor.gray,
                ),
                prefixIcon:
                    (!_isFocused && _isTextEmpty && widget.prefixIcon != null)
                        ? Icon(widget.prefixIcon)
                        : null,
                suffixIcon:
                    widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil.getWidth(14)),
                  borderSide:
                      const BorderSide(color: GlobalColor.grayTextField),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil.getWidth(14)),
                  borderSide:
                      const BorderSide(color: GlobalColor.grayTextField),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil.getWidth(14)),
                  borderSide: const BorderSide(color: GlobalColor.greenButton),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil.getWidth(14)),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil.getWidth(14)),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
