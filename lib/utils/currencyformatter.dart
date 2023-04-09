extension CurrencyFormatting on String {
  String currencyToNoComma() {
    String wow= replaceAll(",", "");
    wow = wow.substring(2);

    return wow;
  }
}