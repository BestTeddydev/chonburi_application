class RateShippingModel {
  int rate;
  double price;
  RateShippingModel({
    required this.rate,
    required this.price,
  });
}

class CalculateShipping {
  double calculateShipping(double totalSize, double weight) {
    double resultSize = calSize(totalSize);
    double resultWeight = calWeight(weight);
    return resultSize > resultWeight ? resultSize : resultWeight;
  }

  double calSize(double totalSize) {
    // totalSize === w + h + long
    List<RateShippingModel> rateSize = [
      RateShippingModel(rate: 40, price: 55),
      RateShippingModel(rate: 60, price: 80),
      RateShippingModel(rate: 75, price: 90),
      RateShippingModel(rate: 90, price: 100),
      RateShippingModel(rate: 105, price: 145),
      RateShippingModel(rate: 120, price: 205),
      RateShippingModel(rate: 150, price: 330),
      RateShippingModel(rate: 200, price: 420),
    ];
    double result = nearNumber(totalSize, rateSize);
    return result;
  }

  double calWeight(double weight) {
    List<RateShippingModel> rateWeight = [
      RateShippingModel(rate: 2, price: 55),
      RateShippingModel(rate: 7, price: 80),
      RateShippingModel(rate: 10, price: 90),
      RateShippingModel(rate: 15, price: 100),
      RateShippingModel(rate: 20, price: 145),
      RateShippingModel(rate: 25, price: 205),
    ];
    double result = nearNumber(weight, rateWeight);
    return result;
  }

  double nearNumber(double rate, List<RateShippingModel> rates) {
    if (rate < 1) {
      return 35;
    }
    double result = 0;
    for (int i = 0; i < rates.length; i++) {
      RateShippingModel rateModel = rates[i];
      if (rateModel.rate == rate) {
        result = rateModel.price;
      }
      if (rateModel.rate > rate && result == 0) {
        result = rateModel.price;
      }
    }
    return result;
  }
}
