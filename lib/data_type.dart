/// 常用数据类型
void main() {
  _numType();
  _stringType();
  _booleanAndListType();
  _dynamicType(1, isTrue: true);
}

/// 数字类型
_numType() {
  num num1 = -123;
  num num2 = 2;
  int num3 = 3;
  double num4 = 4.0;

  num1.abs();
  num1.toDouble();

  num4.toInt();

  print("""
  num1: $num1
  num2: $num2
  num3: $num3
  num4: $num4
  num4 to int : ${num4.toInt()}
  """);
}

/// 字符串类型
_stringType() {
  String string1 = "12313";
  String string2 = '12312312';

  String string3 = string1 + string2;

  String string4 = '$string1 $string2';
  String string5 = "$string1 $string2";

  /// 是从0开始数，然后知道5的位置结束
  String string6 = string5.substring(1, 5);

  num index = string6.indexOf("1");
  string6.length;

  /// 字符串长度
  string6.contains("1");

  /// 是否包含1

  print("""
  string1: $string1
  string2: $string2
  string3: $string3
  string4: $string4
  string5: $string5
  string6: $string6
  index: $index
  """);
}

/// BOOLEAN list 类型使用
_booleanAndListType() {
  num a1 = 1;
  num a2 = 2;

  List<String> list1 = ["1", "2", "3"];
  List<String> list2 = ["1231"];
  list2 = myGenerate(3, (index, type) {
    return index.toString();
  });
  list2.addAll(list1);

   Map ages = <int, String>{1: "123"};
  ages.forEach((key, value) {
    print("key: $key, value: $value");
  });

  Map ags2 = ages.map((a, b) {
    return MapEntry(a + 1, b + " 123");
  });

  for (var key in ags2.keys) {
    print("1412312: $key");
  }

  ags2.forEach((a, b) {
    print("1211 $a, $b");
  });

  list2.forEach((a) {
    print(a);
  });

  print("""
  a1: $a1
  a2: $a2
  list1: $list1
  list2: $list2
  """);
}

// 基础版本：接受函数参数 高阶函数
List<T> myGenerate<T>(int length, T Function(int, String) generator) {
  List<T> result = [];
  for (int i = 0; i < length; i++) {
    result.add(generator(i, "123"));
  }
  return result;
}

/// 动态类型\ var \ object 类型
_dynamicType(int a, {bool? isTrue = true}) {
  B("!231", aas1: "111", aasd2: "123123", aasd3: "1231");
  B.build("!231", aas1: "111", aasd2: "123123", aasd3: "1231");
}

class A {
  static const a = 123;
  static final a1 = "123";
  final a2 = "123";
  static String a3 = "asda";

  A(a, a1) {}

  void testDemo() {
    print('testDemo');
  }

  _testB() {
    print("testB");
  }
}

class B extends A {
  String? aasd;
  String? aas1;
  String? aasd2;
  String? _aasd3;
  get aasd3 => _aasd3;
  set aasd3(value) => _aasd3 = value;

  //默认的构造方法
  B(asad, {this.aas1, this.aasd2, aasd3}) : super(aas1, aas1) {
    print("""
    asad: $asad
    aas1: $aas1
    aasd2: $aasd2
    aasd3: $aasd3
    """);
  }

  // 构建者构造方法
  B.build(asad, {this.aas1, this.aasd2, aasd3}) : super(asad, aas1) {
    print("""
    asad: $asad
    aas1: $aas1
    aasd2: $aasd2
    aasd3: $aasd3
    """);
  }

}
