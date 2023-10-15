import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_master/res/app_context_extension.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? ctrl;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function? validator;
  final FocusNode? focusNode;
  final Function? onFieldSubmitted;
  final bool? isNumberOnly;
  const AppTextFormField(
      {Key? key,
        this.ctrl,
        this.hintText,
        this.keyboardType,
        this.onFieldSubmitted,
        this.focusNode,
        this.validator,
        this.isNumberOnly,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        focusNode: focusNode,
        onFieldSubmitted: (value) => onFieldSubmitted!(value),
        validator: (input) => validator!(input),
        inputFormatters: isNumberOnly! ? <TextInputFormatter>[
           FilteringTextInputFormatter.digitsOnly
        ] : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.res.color.lightGreyColor1,
          hintText: hintText,
          errorMaxLines: 2,
          contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          //hintStyle: const TextStyle(color: Colors.red,),
          //labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),

        ),
      ),
    );
  }}