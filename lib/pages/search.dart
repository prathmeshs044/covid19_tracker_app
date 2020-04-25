import 'package:flutter/material.dart';
class Search extends SearchDelegate{
  final List countryList;
  ThemeData appBarTheme(BuildContext context){
    return Theme.of(context);
  }
  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query='';

      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
        Navigator.pop(context);
      })
    ;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionlist = query.isEmpty?countryList:countryList.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();
    return ListView.builder(itemCount: suggestionlist.length,
        itemBuilder: (context,index){
      return Card(
        color: Theme.of(context).brightness==Brightness.dark?(Colors.black38):(Colors.transparent) ,
        shadowColor: Theme.of(context).brightness==Brightness.dark?(Colors.grey[600]):(Colors.black12),
        child: Container(
          height: 130,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(suggestionlist[index]['country'],style: TextStyle(fontWeight: FontWeight.bold),),
                    Image.network(suggestionlist[index]['countryInfo']['flag'],height: 50.0,width: 60,)
                  ],
                ),
              ),
              Expanded(child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('CONFIRMED:'+suggestionlist[index]['cases'].toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red),),
                    Text('ACTIVE:'+suggestionlist[index]['active'].toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),),
                    Text('RECOVERED:'+suggestionlist[index]['recovered'].toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700]),),
                    Text('DEATHS:'+suggestionlist[index]['deaths'].toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]: Colors.grey[700]),),
                    Text('CASES PER TEN LAKH CITIZENS:'+suggestionlist[index]['casesPerOneMillion'].toString(),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),),

                  ],
                ),



              ),)


            ],
          ),
        ),
      );
    });
  }

}