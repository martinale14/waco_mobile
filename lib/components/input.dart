import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waco_mobile/utils/dimens.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final TextInputType? type;
  final IconData icon;
  final bool hideContent;
  final TextEditingController controller;
  final Function(String) onChange;
  final String validationText;

  const CustomInput({
    Key? key,
    this.label = 'input',
    this.type,
    required this.icon,
    this.hideContent = false,
    required this.controller,
    required this.validationText,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme palette = Theme.of(context).colorScheme;
    BorderRadius radius = const BorderRadius.all(Radius.circular(100));
    return Container(
      alignment: Alignment.center,
      width: dimens.width(context, 0.805),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: validationText.isEmpty ? Colors.white70 : Colors.red,
              ),
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
                    gradient: validationText.isEmpty
                        ? LinearGradient(
                            colors: [palette.primary, palette.secondary])
                        : const LinearGradient(
                            colors: [Colors.red, Colors.red])),
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
                    icon: Icon(
                      icon,
                      color:
                          validationText.isEmpty ? Colors.white70 : Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          validationText.isEmpty
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : const SizedBox(
                  height: 10,
                ),
          Container(
            alignment: Alignment.centerLeft,
            padding: dimens.symmetric(context, 0.05, 0),
            child: validationText.isEmpty
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : Row(
                    children: [
                      const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Text(
                          validationText,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
