part of 'widgets.dart';

class ReusableTextWithNameField extends StatelessWidget {
  final String? text;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool onSuffixIc;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;

  const ReusableTextWithNameField(
      {this.text,
        this.hintText,
        this.controller,
        this.obscureText = false,
        this.suffixIcon,
        this.onSuffixIc = false,
        this.onChanged,
        this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(24, 10, 24, 6),
          child: Text(
            text!,
            style: TextStyle(color: Colors.black),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: TextField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: (onSuffixIc) ? suffixIcon : null,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: hintText),
          ),
        )
      ],
    );
  }
}

class ReusableElevatedButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Color? colorButton;
  final VoidCallback? onPressed;

  const ReusableElevatedButton(
      {this.text, this.textStyle, this.colorButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed!,
      child: Text(
        text!,
        style: textStyle,
      ),
      style: ElevatedButton.styleFrom(
        primary: colorButton,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}