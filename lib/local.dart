import "package:currency_converter/app.dart";
import "package:currency_converter/util/environment/local_environment.dart";
import "package:flutter/material.dart";

void main() async {
  await LocalEnvironment().configure();

  runApp(const CurrencyConverterApp());
}
