import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class CodeScanner {
  String? productName = "Unknown";
  Map itemDetails = {};

  CodeScanner();

  Future<void> openBarCodeScanner() async {
    String scanResult;
    scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);

    Product? product = await getProduct(scanResult);

    if (product == null) {
      productName = "Food not found";
      itemDetails['calories'] = -1.0;
      itemDetails['carbohydrate'] = -1.0;
      itemDetails['protein'] = -1.0;
      itemDetails['fat'] = -1.0;
      itemDetails['saturated'] = -1.0;
      itemDetails['salt'] = -1.0;
      itemDetails['sugar'] = -1.0;
    } else {
      productName = product.productName;
      print(product.nutriments?.toJson());
      print(product.nutriments?.toJson()["salt_100g"]);

      if (product.nutriments?.toJson()["energy_100g"] != null) {
        itemDetails['calories'] = product.nutriments!.toJson()["energy_100g"];
      } else {
        itemDetails['calories'] = -1;
      }

      if (product.nutriments?.toJson()["carbohydrates_100g"] != null) {
        itemDetails['carbohydrate'] =
            product.nutriments!.toJson()["carbohydrates_100g"];
      } else {
        itemDetails['carbohydrate'] = -1;
      }

      if (product.nutriments?.toJson()["proteins_100g"] != null) {
        itemDetails['protein'] = product.nutriments!.toJson()["proteins_100g"];
      } else {
        itemDetails['protein'] = -1;
      }

      if (product.nutriments?.toJson()["fat_100g"] != null) {
        itemDetails['fat'] = product.nutriments!.toJson()["fat_100g"];
      } else {
        itemDetails['fat'] = -1;
      }

      if (product.nutriments?.toJson()["saturated-fat_100g"] != null) {
        itemDetails['saturated'] =
            product.nutriments!.toJson()["saturated-fat_100g"];
      } else {
        itemDetails['saturated'] = -1;
      }

      if (product.nutriments?.toJson()["salt_100g"] != null) {
        itemDetails['salt'] = product.nutriments!.toJson()["salt_100g"];
      } else {
        itemDetails['salt'] = -1;
      }

      if (product.nutriments?.toJson()["sugars_100g"] != null) {
        itemDetails['sugar'] = product.nutriments!.toJson()["sugars_100g"];
      } else {
        itemDetails['sugar'] = -1;
      }
    }
  }

  Future<Product?> getProduct(scanResult) async {
    var barcode = scanResult;

    ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode,
        language: OpenFoodFactsLanguage.GERMAN, fields: [ProductField.ALL]);
    ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

    if (result.status == 1) {
      return result.product;
    } else {
      //throw Exception('product not found, please insert data for $barcode');
      return null;
    }
  }

  String? getItemName() {
    return productName;
  }

  getDetails() {
    return itemDetails;
  }
}
