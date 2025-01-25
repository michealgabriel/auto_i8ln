import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'auto_i8nl_gen.dart';

class AutoText extends StatelessWidget {
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
  const AutoText(this.text,
      {super.key,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.selectionColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      autoI8lnGen.translate(text),
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

class AutoTextSpan {
  final String? text;
  final List<InlineSpan>? children;
  final TextStyle? style;
  final GestureRecognizer? recognizer;
  final MouseCursor? mouseCursor;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final String? semanticsLabel;
  final Locale? locale;
  final bool? spellOut;
  AutoTextSpan(
      {this.text,
      this.children,
      this.style,
      this.recognizer,
      this.mouseCursor,
      this.onEnter,
      this.onExit,
      this.semanticsLabel,
      this.locale,
      this.spellOut}) {
    textSpan();
  }

  InlineSpan textSpan() {
    return TextSpan(
      text: autoI8lnGen.translate("HELLO_MESSAGE"),
      children: children,
      style: style,
      recognizer: recognizer,
      mouseCursor: mouseCursor,
      onEnter: onEnter,
      onExit: onExit,
      semanticsLabel: semanticsLabel,
      locale: locale,
      spellOut: spellOut,
    );
  }
}
