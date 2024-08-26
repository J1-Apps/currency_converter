import "package:currency_converter/app.dart";
import "package:currency_converter/util/environment/prod_environment.dart";
import "package:flutter/material.dart";

void main() async {
  await ProdEnvironment().configure();

  runApp(const CurrencyConverterApp());
}
