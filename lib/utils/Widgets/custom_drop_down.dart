import '../../res/import/import.dart';

class DropDownInput extends StatelessWidget {
  const DropDownInput({
    super.key,
    this.controller,
    required this.items,
    this.hint,
    this.onSelected,
    this.validator,
    this.enabled = true,
    this.fillColor,
  });

  final TextEditingController? controller;
  final List<String> items;
  final String? hint;
  final String? Function(String?)? validator;
  final Function(String? val)? onSelected;
  final bool enabled;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextFormField(
        showCursor: false,
        controller: controller,
        validator: validator,
        enabled: enabled,
        readOnly: true,
        style: TaskManagerTextStyle.size16.copyWith(
          fontWeight: FontWeight.w400,
          color: taskManagerBlack,
        ),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: fillColor ?? taskManagerWhite,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: taskManagerGrey.withOpacity(.5), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: taskManagerGrey.withOpacity(.5), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: taskManagerPrimaryColor.withOpacity(0.6), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: taskManagerPrimaryColor),
          ),
          suffixIcon: PopupMenuButton<String>(
            icon: const Icon(Icons.expand_more),
            onSelected: (String? val) {
              if (onSelected == null) return;

              onSelected!(val);
            },
            itemBuilder: (BuildContext context) {
              return items.map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem(value: value, child: Text(value));
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
