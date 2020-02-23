class CheckOutService{
    /// 计算总价
  static computTotalPrice(checkOutList) {
    double tempPrice = 0;
    for (var i = 0; i < checkOutList.length; i++) {
      Map map = checkOutList[i];
      if (map['checked'] == true) {
        tempPrice += map['price'] * map['count'];
      }
    }
    return tempPrice;
  }
}