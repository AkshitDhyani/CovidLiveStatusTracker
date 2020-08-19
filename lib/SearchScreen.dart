import 'dart:convert';

import 'package:covid/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchScreen> {
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v3/covid-19/countries');
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: peachBack,
      appBar: AppBar(
        backgroundColor: blackBack,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: searchCountry(countryData));
            },
          )
        ],
        title: Text("Countries"),
      ),
      body: countryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        countryData[index]['country'].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              width: 100,
                              height: 70,
                              child: Image.network(
                                  countryData[index]['countryInfo']['flag'])),
                          Column(
                            children: <Widget>[
                              Text(
                                "Cases: " +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                  color: redBack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Deaths: " +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                  color: redBack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Active: " +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                  color: redBack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Recovered: " +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                  color: redBack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}

class searchCountry extends SearchDelegate {

  List countryList;

  searchCountry(this.countryList);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty?countryList:countryList.where((element) => element['country'].toString().toLowerCase().contains(query)).toList();
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                suggestionList[index]['country'].toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      width: 100,
                      height: 70,
                      child: Image.network(
                          suggestionList[index]['countryInfo']['flag'])),
                  Column(
                    children: <Widget>[
                      Text(
                        "Cases: " +
                            suggestionList[index]['cases'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Deaths: " +
                            suggestionList[index]['deaths'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Active: " +
                            suggestionList[index]['active'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Recovered: " +
                            suggestionList[index]['recovered'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );git init
      },
      itemCount: suggestionList == null ? 0 : suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?countryList:countryList.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                suggestionList[index]['country'].toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      width: 100,
                      height: 70,
                      child: Image.network(
                          suggestionList[index]['countryInfo']['flag'])),
                  Column(
                    children: <Widget>[
                      Text(
                        "Cases: " +
                            suggestionList[index]['cases'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Deaths: " +
                            suggestionList[index]['deaths'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Active: " +
                            suggestionList[index]['active'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Recovered: " +
                            suggestionList[index]['recovered'].toString(),
                        style: TextStyle(
                          color: redBack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: suggestionList == null ? 0 : suggestionList.length,
    );
  }
}
