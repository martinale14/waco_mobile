import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final TextInputType? type;
  final Icon? icon;
  final bool hideContent;
  final TextEditingController controller;
  final Function(String) onChange;
  const CustomInput(
      {Key? key,
      this.label = 'input',
      this.type,
      this.icon,
      this.hideContent = false,
      required this.controller,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    BorderRadius radius = const BorderRadius.all(Radius.circular(100));
    return Container(
      alignment: Alignment.center,
      width: dimens.width(context, 0.8),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: radius,
                    gradient: LinearGradient(
                        colors: [palette.primary, palette.secondary])),
              ),
              Container(
                padding: dimens.symmetric(context, .04, 0),
                width: dimens.width(context, 0.79),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  color: palette.surface,
                ),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    onChange(value);
                  },
                  obscureText: hideContent ? true : false,
                  enableSuggestions: hideContent ? false : true,
                  autocorrect: hideContent ? false : true,
                  keyboardType: type ?? TextInputType.text,
                  style: const TextStyle(color: Colors.white70, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: icon ??
                        const Icon(
                          Icons.text_fields,
                          color: Colors.white70,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
