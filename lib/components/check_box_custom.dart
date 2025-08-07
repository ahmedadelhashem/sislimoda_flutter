import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final Widget? label;

  final ValueChanged<bool?>? onChanged;
  final TextStyle? labelStyle;

  const AppCheckbox({Key? key, this.label, this.onChanged, this.labelStyle})
      : super(key: key);

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        setState(() {
          value = !value;
          widget.onChanged!(value);
        });
      },
      child: Container(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scale: .9,
              child: Checkbox(
                  //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: value,
                  onChanged: (va) {
                    widget.onChanged!(va);
                    value = va!;
                    setState(() {});
                  },
                  activeColor: Theme.of(context).primaryColor),
            ),
            widget.label!
          ],
        ),
      ),
    );
  }
}
