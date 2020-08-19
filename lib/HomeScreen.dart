import 'dart:convert';

import 'package:covid/FadeAnimation.dart';
import 'package:covid/ShowMap.dart';
import 'package:covid/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  Map<String, double> dataMap = new Map();
  Map worldData;
  List countryData;

  fetchWorldData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v3/covid-19/all');
    setState(() {
      worldData = jsonDecode(response.body);
      dataMap.putIfAbsent("Deaths", () => worldData['deaths'].toDouble());
      dataMap.putIfAbsent("Active", () => worldData['active'].toDouble());
      dataMap.putIfAbsent("Recovered", () => worldData['recovered'].toDouble());
    });
  }

  fetchCountryData() async {
    http.Response response = await http
        .get('https://corona.lmao.ninja/v3/covid-19/countries?sort=cases');
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountryData();
    fetchWorldData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: peachBack,
      body: WillPopScope(
        onWillPop: () async => false,
        child: worldData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                "Global Stats",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: blackBack),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen()),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: dataMap == null
                                  ? CircularProgressIndicator()
                                  : PieChart(
                                      dataMap: dataMap,
                                      animationDuration:
                                          Duration(milliseconds: 1000),
                                      chartType: ChartType.ring,
                                    ),
                            ),
                          ),

                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: FadeAnimation(
                            0.8,
                            Card(
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(worldData['cases'].toString(),
                                          style: TextStyle(
                                              color: blackBack,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      child: Text(
                                        "Total Cases",
                                        style: TextStyle(
                                            color: orangeBack, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: FadeAnimation(
                            1,Card(
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                              worldData['active'].toString(),
                                              style: TextStyle(
                                                  color: blackBack,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Container(
                                          child: Text(
                                            "Active",
                                            style: TextStyle(
                                                color: orangeBack,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: FadeAnimation(
                                  1,
                                  Card(
                                    color: Colors.white,
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                                worldData['deaths'].toString(),
                                                style: TextStyle(
                                                    color: blackBack,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            child: Text(
                                              "Deaths",
                                              style: TextStyle(
                                                  color: orangeBack,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: FadeAnimation(
                                  1,
                                  Card(
                                    color: Colors.white,
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                                worldData['recovered']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: blackBack,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            child: Text(
                                              "Recovered",
                                              style: TextStyle(
                                                  color: orangeBack,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: FadeAnimation(
                                  1,Card(
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                              worldData['critical'].toString(),
                                              style: TextStyle(
                                                  color: blackBack,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Container(
                                          child: Text(
                                            "Critical",
                                            style: TextStyle(
                                                color: orangeBack,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Most Affected Countries",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: SizedBox(),),
                              Container(
                                child: RaisedButton(onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowMap()),
                                  );
                                },child: Text("Open Map"),
                                  color: orangeBack,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: countryData == null
                              ? CircularProgressIndicator()
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.fromLTRB(35, 10, 15, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              width: 70,
                                              height: 50,
                                              child: Image.network(
                                                  countryData[index]
                                                      ['countryInfo']['flag'])),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                countryData[index]['country']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "Cases: " +
                                                    countryData[index]['cases']
                                                        .toString(),
                                                style: TextStyle(
                                                  color: redBack,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: 5,
                                ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
