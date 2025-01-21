
import 'package:flutter/material.dart';
import 'auto_i8nl_gen.dart';

class AutoText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  const AutoText(this.text, {super.key, this.style, this.strutStyle, this.textAlign, this.textDirection, this.locale, this.softWrap, this.overflow, this.textScaleFactor, this.maxLines, this.semanticsLabel, this.textWidthBasis, this.textHeightBehavior, this.selectionColor});

  @override
  State<AutoText> createState() => _AutoTextState();
}

class _AutoTextState extends State<AutoText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      autoI8lnGen.translate(widget.text),
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaleFactor: widget.textScaleFactor,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
      selectionColor: widget.selectionColor,
    );
  }
}