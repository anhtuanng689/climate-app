import 'package:flutter/material.dart';

/*Utils*/
Color colorFromHexs(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

const double _kHeight = 25;
enum OrderType { Ascending, Descending, None }
/*Utils*/

class MyAssets {
  final double size;
  final int num;

  MyAssets({this.size, this.num});
}

class DetailProgressBar extends StatelessWidget {
  DetailProgressBar({
    Key key,
    @required this.width,
    this.height = _kHeight,
    this.radius,
    this.assets,
    this.assetsLimit,
    this.order,
  })  : assert(width != null),
        assert(assets != null),
        super(key: key);

  final double width;
  final double height;
  final double radius;
  final List<MyAssets> assets;
  final double assetsLimit;
  final OrderType order;

  double _getValuesSums() {
    double sum = 0;
    assets.forEach((single) => sum += single.size);
    return sum;
  }

  void orderMyAssetsLists() {
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
  Widget _createSingles(MyAssets singleAsset) {
    return SizedBox(
      width: (singleAsset.size * width) / (assetsLimit ?? _getValuesSums()),
      child: Container(
        child: Text(
          singleAsset.num.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (assetsLimit != null && assetsLimit < _getValuesSums()) {
      print("assetsSum < _getValuesSum() - Check your values!");
      return Container();
    }

    //Order assetsList
    orderMyAssetsLists();

    final double rad = radius ?? (height / 2);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(rad)),
      child: Container(
        width: width,
        height: height,
        child: Row(
            children: assets
                .map((singleAsset) => _createSingles(singleAsset))
                .toList()),
      ),
    );
  }
}
