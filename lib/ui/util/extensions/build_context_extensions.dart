import "package:flutter/material.dart";
import "package:currency_converter/ui/util/localization/app_localizations.dart";

extension BuildContextExtensions on BuildContext {
  Strings strings() {
    return Strings.of(this);
  }
}
