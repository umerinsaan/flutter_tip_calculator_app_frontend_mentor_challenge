// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'SpaceMono'),
    home: const TipCalculatorApp(),
  ));
}

class TipCalculatorApp extends StatefulWidget {
  const TipCalculatorApp({super.key});

  @override
  State<TipCalculatorApp> createState() => _TipCalculatorAppState();
}

class _TipCalculatorAppState extends State<TipCalculatorApp> {
  final billInputFocusNode = FocusNode();
  final numberOfPeopleInputFocusNode = FocusNode();

  final billInputController = TextEditingController();
  final numberOfPeopleInputController = TextEditingController();
  final customTipPercentageController = TextEditingController();

  bool isCustomTip = false;
  double tipPercentage = 0;

  double tipAmount = 0;
  double total = 0;

  double bill = 0;
  int numberOfPeople = 0;

  bool billInputFocused = false;
  bool numberOfPeopleInputFocused = false;

  void calculate() {
    if (numberOfPeople == 0) return;
    tipAmount = (bill * (tipPercentage / 100)) / numberOfPeople;
    total = bill / numberOfPeople + tipAmount;

    tipAmount = double.parse(tipAmount.toStringAsFixed(2));
    total = double.parse(total.toStringAsFixed(2));
  }

  void reset() {
    numberOfPeople = 0;
    tipAmount = 0;
    tipPercentage = 0;
    total = 0;
    bill = 0;

    billInputFocused = false;
    numberOfPeopleInputFocused = false;

    isCustomTip = false;

    billInputController.clear();
    numberOfPeopleInputController.clear();
    customTipPercentageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        elevation: 0,
        title: const Center(
          child: Text(
            'SPLITTER',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'SpaceMono',
              letterSpacing: 15,
              color: Color.fromRGBO(94, 122, 125, 1),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(197, 228, 231, 1),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bill',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(94, 122, 125, 1),
                    fontFamily: 'SpaceMono',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: (billInputFocused)
                      ? Border.all(
                          color: const Color.fromRGBO(38, 192, 171, 1),
                          width: 2,
                        )
                      : null,
                  color: const Color.fromRGBO(244, 250, 250, 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'SpaceMono',
                        // fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 73, 77, 0.5),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: billInputController,
                        focusNode: billInputFocusNode,
                        onSubmitted: (value) {
                          setState(() {
                            billInputFocused = false;
                          });
                        },
                        onTapOutside: (event) {
                          setState(() {
                            billInputFocusNode.unfocus();
                            billInputFocused = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            billInputFocused = true;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            bill = double.tryParse(value) ?? 0;
                            calculate();
                          });
                        },
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'SpaceMono',
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 73, 77, 1), //Very dark cyan
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: TextStyle(
                            fontFamily: 'SpaceMono',
                            color: Color.fromRGBO(0, 73, 77, 0.5),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Tip %',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(94, 122, 125, 1),
                    fontFamily: 'SpaceMono',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tipPercentage = 5;
                              calculate();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tipPercentage == 5
                                ? Color.fromRGBO(38, 192, 171, 1)
                                : const Color.fromRGBO(0, 73, 77, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                          ),
                          child: Text(
                            '5%',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: tipPercentage == 5
                                  ? Color.fromRGBO(0, 73, 77, 1)
                                  : Colors.white,
                              fontFamily: 'SpaceMono',
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tipPercentage = 10;
                              calculate();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tipPercentage == 10
                                ? Color.fromRGBO(38, 192, 171, 1)
                                : const Color.fromRGBO(0, 73, 77, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                          ),
                          child: const Text(
                            '10%',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'SpaceMono',
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tipPercentage = 15;
                              calculate();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tipPercentage == 15
                                ? Color.fromRGBO(38, 192, 171, 1)
                                : const Color.fromRGBO(0, 73, 77, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                          ),
                          child: const Text(
                            '15%',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'SpaceMono',
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tipPercentage = 25;
                              calculate();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tipPercentage == 25
                                ? Color.fromRGBO(38, 192, 171, 1)
                                : const Color.fromRGBO(0, 73, 77, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                          ),
                          child: const Text(
                            '25%',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'SpaceMono',
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tipPercentage = 50;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tipPercentage == 50
                                ? Color.fromRGBO(38, 192, 171, 1)
                                : const Color.fromRGBO(0, 73, 77, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                          ),
                          child: const Text(
                            '50%',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'SpaceMono',
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(244, 250, 250, 1),
                            borderRadius: BorderRadius.circular(8),
                            border: (isCustomTip)
                                ? Border.all(
                                    color:
                                        const Color.fromRGBO(38, 192, 171, 1),
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                tipPercentage = double.tryParse(value) ?? 0;
                                isCustomTip = value.isNotEmpty;
                                calculate();
                              });
                            },
                            controller: customTipPercentageController,
                            textAlign: TextAlign.right,
                            cursorColor: const Color.fromRGBO(38, 192, 171, 1),
                            decoration: InputDecoration(
                              hintText: 'Custom',
                              hintStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(94, 122, 125, 1),
                                fontFamily: 'SpaceMono',
                                letterSpacing: 2,
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromRGBO(38, 192, 171, 1),
                                  width: 2,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 7,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 73, 77, 1),
                              fontFamily: 'SpaceMono',
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Number of People',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(94, 122, 125, 1),
                    fontFamily: 'SpaceMono',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: (numberOfPeopleInputFocused)
                      ? Border.all(
                          color: const Color.fromRGBO(38, 192, 171, 1),
                          width: 2,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(244, 250, 250, 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Color.fromRGBO(0, 73, 77, 0.5),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        focusNode: numberOfPeopleInputFocusNode,
                        controller: numberOfPeopleInputController,
                        onSubmitted: (value) {
                          setState(() {
                            numberOfPeopleInputFocused = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            numberOfPeopleInputFocused = true;
                          });
                        },
                        onTapOutside: (event) {
                          setState(() {
                            numberOfPeopleInputFocused = false;
                            numberOfPeopleInputFocusNode.unfocus();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            numberOfPeople = int.tryParse(value) ?? 0;
                            calculate();
                          });
                        },
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'SpaceMono',
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 73, 77, 1), //Very dark cyan
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: TextStyle(
                            fontFamily: 'SpaceMono',
                            color: Color.fromRGBO(0, 73, 77, 0.5),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 73, 77, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tip Amount',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SpaceMono',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              '/ person',
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                                fontFamily: 'SpaceMono',
                              ),
                            )
                          ],
                        ),
                        Text(
                          '\$$tipAmount',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(38, 192, 171, 1),
                            fontFamily: 'SpaceMono',
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SpaceMono',
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              '/ person',
                              style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                                fontFamily: 'SpaceMono',
                              ),
                            )
                          ],
                        ),
                        Text(
                          '\$$total',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(38, 192, 171, 1),
                            fontFamily: 'SpaceMono',
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(38, 192, 171, 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            onPressed: () {
                              setState(() {
                                reset();
                              });
                            },
                            child: Text(
                              'RESET',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 73, 77, 1),
                                fontFamily: 'SpaceMono',
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
