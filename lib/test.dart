import "package:currency_converter/app.dart";
import "package:currency_converter/ui/util/environment/test_environment.dart";
import "package:flutter/material.dart";

void main() async {
  await TestEnvironment().configure();

  runApp(CurrencyConverterApp());
}
