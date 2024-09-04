import '../../res/import/import.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String? val)? validator;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String? val)? onchanged;
  final Function(String? val)? onfieldSubmitted;
  final Function(String? val)? onsaved;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? titleText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final double? height;
  final double? borderRadius;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? readonly;
  final bool? autofocus;
  final bool? autocorrect;
  const CustomTextFormField({
    super.key,
    this.validator,
    this.autofocus,
    this.autocorrect,
    this.label,
    this.controller,
    this.onfieldSubmitted,
    this.textInputType,
    this.obscureText,
    this.onchanged,
    this.onsaved,
    this.textInputAction,
    this.hintText,
    this.minLines,
    this.titleText,
    this.textStyle,
    this.maxLength,
    this.maxLines,
    this.height,
    this.textInputFormatter,
    this.readonly,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.focusedBorderColor,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.fillColor,
    this.hintStyle,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: textInputType,
      inputFormatters: textInputFormatter,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onchanged,
      onSaved: onsaved,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      readOnly: readonly ?? false,
      onTap: onTap,
      autofocus: autofocus ?? false,
      autocorrect: autocorrect ?? false,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: onfieldSubmitted,
      style: textStyle ??
          TaskManagerTextStyle.size16
              .copyWith(fontWeight: FontWeight.w400, color: taskManagerBlack),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        hintStyle: hintStyle ??
            TaskManagerTextStyle.size12
                .copyWith(fontWeight: FontWeight.w400, color: taskManagerGrey),
        fillColor: fillColor ?? taskManagerFillColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: enabledBorderColor ??
                  taskManagerPrimaryColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor ?? Colors.red),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedBorderColor ?? taskManagerPrimaryColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r)),
        labelStyle: TaskManagerTextStyle.size16.copyWith(
            color: taskManagerPrimaryColor, fontWeight: FontWeight.w700),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: 13.sp,
        ),
      ),
    );
  }
}

Widget inputFieldTitle(title, {Color? color}) => Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Text(title, style: TaskManagerTextStyle.size16.copyWith()),
    );

class CustomTextFormFieldDropDown extends StatelessWidget {
  final String? Function(String? val)? validator;
  final String? label;
  final Function(String? val)? onchanged;
  final Function(String? val)? onsaved;
  final Function()? onTap;
  final String? hintText;
  final String? titleText;
  final TextStyle? textStyle;
  final List<String> items;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextFormFieldDropDown({
    super.key,
    required this.items,
    this.validator,
    this.label,
    this.onchanged,
    this.onsaved,
    this.hintText,
    this.titleText,
    this.textStyle,
    this.height,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.fillColor,
    this.errorBorderColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.borderRadius,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      onChanged: onchanged,
      onSaved: onsaved,
      onTap: onTap,
      isExpanded: true,
      icon: SizedBox(
        width: (24).sp,
        height: (24).sp,
        child: const Icon(
          Icons.keyboard_arrow_down,
          color: taskManagerGrey,
        ),
      ),
      style: textStyle ??
          TaskManagerTextStyle.size16
              .copyWith(fontWeight: FontWeight.w400, color: taskManagerBlack),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        hintStyle: TaskManagerTextStyle.size12
            .copyWith(fontWeight: FontWeight.w400, color: taskManagerGrey),
        fillColor: fillColor ?? taskManagerTransparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: enabledBorderColor ??
                  taskManagerPrimaryColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor ?? Colors.red),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedBorderColor ?? taskManagerPrimaryColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r)),
        labelStyle: TaskManagerTextStyle.size16.copyWith(
            color: taskManagerPrimaryColor, fontWeight: FontWeight.w700),
        prefixIcon: prefixIcon,
        prefixIconColor: taskManagerPrimaryColor,
        suffixIconColor: taskManagerPrimaryColor,
        suffix: suffixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 13,
        ),
      ),
      items: items.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: TaskManagerTextStyle.size16.copyWith(
                fontWeight: FontWeight.w400, color: taskManagerTextColor),
          ),
        );
      }).toList(),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final String value;
  final String? groupValue;
  final Function(String?) onChanged;
  const CustomRadio({
    super.key,
    required this.value,
    required this.onChanged,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: taskManagerBlack,
        border: Border.all(
          color:
              value == groupValue ? taskManagerPrimaryColor : taskManagerGrey,
          width: value == groupValue ? 1 : 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          if (value == groupValue)
            BoxShadow(
              blurRadius: 8,
              color: taskManagerPrimaryColor.withOpacity(0.24),
            ),
        ],
      ),
      child: RadioListTile(
        selected: value == groupValue,
        tileColor: taskManagerBlack,
        selectedTileColor: taskManagerBlack,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: taskManagerPrimaryColor,
        visualDensity: VisualDensity.compact,
        title: Text(
          value,
          style: TaskManagerTextStyle.size14.copyWith(
            fontWeight: FontWeight.w500,
            color: taskManagerTextColor,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(
            // horizontal: 20,
            // vertical: 16,
            ),
      ),
    );
  }
}
