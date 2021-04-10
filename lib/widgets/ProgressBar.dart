import 'package:flutter/material.dart';

/*Utils*/
Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

const double _kHeight = 25;
enum OrderType { Ascending, Descending, None }
/*Utils*/

class MyAsset {
  final double size;
  final Color color;

  MyAsset({this.size, this.color});
}

class MyAssetsBar extends StatelessWidget {
  MyAssetsBar(
      {Key key,
      @required this.width,
      this.height = _kHeight,
      this.radius,
      this.assets,
      this.assetsLimit,
      this.order,
      this.background = Colors.grey})
      : assert(width != null),
        assert(assets != null),
        super(key: key);

  final double width;
  final double height;
  final double radius;
  final List<MyAsset> assets;
  final double assetsLimit;
  final OrderType order;
  final Color background;

  double _getValuesSum() {
    double sum = 0;
    assets.forEach((single) => sum += single.size);
    return sum;
  }

  void orderMyAssetsList() {
    switch (order) {
      case OrderType.Ascending:
        {
          //From the smallest to the largest
          assets.sort((a, b) {
            return a.size.compareTo(b.size);
          });
          break;
        }
      case OrderType.Descending:
        {
          //From largest to smallest
          assets.sort((a, b) {
            return b.size.compareTo(a.size);
          });
          break;
        }
      case OrderType.None:
      default:
        {
          break;
        }
    }
  }

  //single.size : assetsSum = x : width
  Widget _createSingle(MyAsset singleAsset) {
    return SizedBox(
      width: (singleAsset.size * width) / (assetsLimit ?? _getValuesSum()),
      child: Container(color: singleAsset.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (assetsLimit != null && assetsLimit < _getValuesSum()) {
      print("assetsSum < _getValuesSum() - Check your values!");
      return Container();
    }

    //Order assetsList
    orderMyAssetsList();

    final double rad = radius ?? (height / 2);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(rad)),
      child: Container(
        decoration: new BoxDecoration(
          color: background,
        ),
        width: width,
        height: height,
        child: Row(
            children: assets
                .map((singleAsset) => _createSingle(singleAsset))
                .toList()),
      ),
    );
  }
}
