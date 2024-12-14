import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_async/src/config/theme/theme.dart';
import 'package:time_async/src/feature/login/model/login_form_model.dart';

class AuthForm extends StatefulWidget {
  AuthForm({
    required this.formModel,
    this.maxLine,
    this.ontap,
    super.key,
  });

  FormModel formModel;
  VoidCallback? ontap;
  int? maxLine;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0), // Adjust for spacing around the card
      decoration: BoxDecoration(
        color: AppTheme.lightAppColors.maincolor, // Card background color
        borderRadius: BorderRadius.circular(30), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurRadius: 6, // How blurry the shadow is
            spreadRadius: 10, // How much the shadow spreads
            offset: const Offset(2, 4), // Position of the shadow
          ),
        ],
      ),
      child: TextFormField(
          onTap: widget.ontap,
          onChanged: widget.formModel.onChange,
          maxLines: widget.maxLine ?? 1,
          minLines: widget.maxLine ?? 1,
          textInputAction: TextInputAction.done,
          cursorColor: AppTheme.lightAppColors.black,
          style: TextStyle(
            color: AppTheme.lightAppColors.mainTextcolor,
            fontSize: 20,
            letterSpacing: 1,
          ),
          readOnly: widget.formModel.enableText,
          inputFormatters: widget.formModel.inputFormat,
          keyboardType: widget.formModel.type,
          validator: widget.formModel.validator,
          obscureText: widget.formModel.invisible,
          controller: widget.formModel.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.formModel.icon,
              size: 35,
              // weight: 1,
              color: AppTheme.lightAppColors.black.withOpacity(0.3),
            ),
            filled: true,
            fillColor: AppTheme.lightAppColors.background.withOpacity(0.9),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.lightAppColors.mainTextcolor.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            hintText: "  ${widget.formModel.hintText.tr}",
            hintStyle: TextStyle(
              fontFamily: "kanti",
              fontWeight: FontWeight.w200,
              letterSpacing: .5,
              color: AppTheme.lightAppColors.mainTextcolor.withOpacity(.5),
              fontSize: 20,
            ),
          )),
    );
  }
}
