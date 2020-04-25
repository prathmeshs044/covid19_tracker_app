import 'dart:convert';

import 'package:covid19trackerapp/pages/countryPage.dart';
import 'package:covid19trackerapp/panels/infoPanel.dart';
import 'package:covid19trackerapp/panels/mosteffectedcountries.dart';
import 'package:covid19trackerapp/panels/worldwidepanel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19trackerapp/datasource.dart';
import 'package:http/http.dart' as http;
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Map worldData;

  fetchWorldWideData()async{
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });

  }
  List countryData;

  fetchCountryData()async{
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });

  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light ? Icons.lightbulb_outline:Icons.highlight) ,

              onPressed: (){
                DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light? Brightness.dark:Brightness.light);
              }),
        ],
        centerTitle: false,
        title: Text('COVID-19 TRACKER'),
      ),
      body: SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            color: Colors.orange[100],
            child: Text(DataSource.quote,style: TextStyle(color: Colors.orange[800],
                fontWeight: FontWeight.bold,
                fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Worldwide',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: primaryBlack,
                        borderRadius: BorderRadius.circular(9)
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Text(' All Countries',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                  ),
                ),
              ],
            ),
          ),
          worldData == null? Center(child: CircularProgressIndicator(),): WorldwidePanel(worldData: worldData),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Text('Most Affected Countries',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        ),
          SizedBox(height: 10,),
          countryData == null ? Container():MostAffectedPanel(countryData: countryData,),
          InfoPanel(),
          SizedBox(height: 20,),
          Center(child: Text('WE ARE TOGETHER IN THIS FIGHT!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
          SizedBox(height: 50,)
        ],
      ),
      ),
    );
  }
}
