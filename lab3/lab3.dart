// lab3.dart - Campus Cafe Order System
// Name: ____________________ Roll no: ____________
const String rollNo = '04072313025'; // e.g. '2100672347'
// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;

//task 1.1
class Dish {
  late String name;
  late int price;
}

//task 2.1
class MenuItem {
  String name;
  int price;
  MenuItem(this.name, this.price) {
    //task2.2
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }
  //task 3.1
  MenuItem.free(this.name) : price = 0;
  //task 3.2
  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);
}

//task 4.1
class OrderLog {
  //_ is used with instance and internal to make them private within the class. bu this they cannot be accessed outside the class
  static OrderLog? _instance;
  final List<String> entries = [];
  OrderLog._internal(); // private named constructor
  // TODO: factory OrderLog() { ... } // always the same object
  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }
  void add(String msg) => entries.add(msg);
}

//task 5.1
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;
  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = (item.price * qty) * taxPercent ~/ 100, //error for using total is because we cant we use it while its not been initialized yet in the initializer list
      assert(qty > 0, 'qty must be positive');
  //task 6.1
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => item.name + ' x' + qty.toString();
}

//task 5.2
OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

//task 7.1
class StudentCard {
  final String owner;
  int _balance; // private backing field
  StudentCard(this.owner) : _balance = 0;
  int get balance => _balance;
  // TODO: set balance(int v) { ... }
  set balance(int v){//setter can thorw exception instead of silently clamping bad value 
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

// ===========================================================================
void main() {
  print('Seed: $seed (t=$t, u=$u)');
  // step1();
  // step2();
  // step3();
  // step4();
  // step5();
  // step6();
  step7();
  // step8();
  // step9();
  // step10();
}

void step1() {
  //task1.2
  Dish item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);
  Dish item2 = Dish();
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);

  item2.price = item2.price - u;
  print('--- Step 1 ---');
  print('Step 1: item1: ${item1.name} Rs: ${item1.price}');
  print('Step 1: item2: ${item2.name} Rs: ${item2.price}');
}

void step2() {
  //task 2.3
  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem('Test Special', 15 * u);
  print('--- Step 2 ---');
  print('Step 2: ${a.name} Rs ${a.price}');
  print('Test Special Rs ${b.price}'); //final use to set value only once but here we are changing it again if its below the priceFloor so we are using it for that
}

void step3() {
  //task 3.3
  print('--- Step 3 ---');
  MenuItem freebie = MenuItem.free('Water'); //becuase we explicitly calling the named constructor so named constructor logic will run
  int i = (u + 2) % 10;
  MenuItem parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=${priceFloor} free price=${freebie.price}');
}

void step4() {
  //task 4.2
  OrderLog log1 = OrderLog();
  OrderLog log2 = OrderLog();
  for (int i = 1; i <= u + 2; i++) {
    String message = 'order #${100 * t + i}';
    if (i % 2 == 1) {
      log1.add(message);
    } else {
      log2.add(message);
    }
  }
  print('--- Step 4 ---');
  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

void step5() {
  //task 5.3
  print('--- Step 5 ---');
  OrderLine order = mainOrder();
  print('Step 5: ${order.item.name} x${order.qty}');
  print('Step 5: total=${order.total} tax=${order.tax}');
  try {
    OrderLine(order.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

void step6() {
  //task 6.2
  print('--- Step 6 ---');
  OrderLine order = mainOrder();
  print('Step 6: grand=${order.grand}');
  print('Step 6: big order? ${order.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${order.label}');
  //task 6.3
  // order.grand=5;
  // this line fails because we dont have setter for that
  //we have to add setter for this to make it legal
}

void step7() {
  //task 7.2
  print('--- Step 7 ---');
  StudentCard card = StudentCard('S$seed');
  card.balance=seed*10+50;
  print('Step 7: topped up->${card.balance}');
  card.balance=-seed-1;
  print('Step 7: bad value->${card.balance}');
  card.balance=balanceCap-u;
  print('Step 7: reset->${card.balance}');
  card.balance=card.balance-mainOrder().grand;
  print('Step 7: paid order->${card.balance}');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
