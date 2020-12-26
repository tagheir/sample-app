import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:bluebellapp/resources/constants/helper_constants/extensions.dart';

double getCardHeight(
    int index1, int cols, var categories, double availableWidth) {
  double height;
  double imageHeight = availableWidth + 11;
  int cardNumber = index1;
  int rowNumber = (cardNumber / cols).floor();
  int skippingCount = rowNumber * cols;
  var currentRow = categories.skip(skippingCount).take(cols);
  List<int> textLengths = [];
  currentRow.forEach((t) => {textLengths.add(t.name.trim().length)});
  height = getNewCardHeight(
      textLengths.reduce(max).toDouble(), imageHeight, availableWidth, cols);
  return height;
}

double getNewCardHeight(
    double max, double height, double availableWidth, int cols,
    {bool isCategory = false}) {
  //var charactersWidth = max * (isCategory == true ? 6.45 : 8.45);
  var newHeight = height + (isCategory == true ? 0 : 50);
  return newHeight;
}

double getMaxCardHeight(List<String> texts, double availableWidth, int col) {
  List<int> textLengths = [];
  double imageHeight = availableWidth + 11;
  texts.forEach((t) => {textLengths.add(t.trim().length)});
  return getNewCardHeight(
      textLengths.reduce(max).toDouble(), imageHeight, availableWidth, col);
}

List<Widget> getGridRowsList<T>(
    int count, List<Widget> gridList, double availableWidth,
    {bool addDummyCard = true}) {
  if (gridList == null) return null;
  List<Widget> gridRows = List<Widget>();
  int totalCells = (gridList.length / count).ceil() * count;
  var counter = 0;
  for (var i = 0; i < totalCells / count; i++) {
    var rowItems = List<Widget>();
    for (var j = 0; j < count; j++) {
      if (counter < gridList.length) {
        rowItems.add(gridList[counter++]);
      } else {
        if (addDummyCard == true) {
          rowItems.add(Container(width: availableWidth, child: Text('')));
        } else {
          rowItems.add(Text(''));
        }
      }
    }
    var row = IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rowItems,
    )).padding(EdgeInsets.only(bottom: 8));
    gridRows.add(row);
  }
  return gridRows;
}
