import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TambonsPage extends StatefulWidget {
  final amphure_id, amphure_name;
  const TambonsPage({super.key, this.amphure_id, this.amphure_name});

  @override
  State<TambonsPage> createState() => _TambonsPageState();
}

class _TambonsPageState extends State<TambonsPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  List<dynamic> tambons = [];
  var _amphure_id, _amphure_name;
  Future<void> loadTombons() async {
    final String jsonData =
        await rootBundle.loadString('assets/thai_tambons.json');
    final Map<String, dynamic> jsonDataMap = json.decode(jsonData);
    final List<dynamic> records = jsonDataMap['RECORDS'];
    setState(() {
      tambons =
          records.where((item) => item['amphure_id'] == _amphure_id).toList();
      searchResults = tambons;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTombons();
    _amphure_id = widget.amphure_id;
    _amphure_name = widget.amphure_name;
  }

  void search(String query) {
    setState(() {
      searchResults = tambons.where((item) {
        final nameEn = item['name_en'].toLowerCase();
        final nameTh = item['name_th'].toLowerCase();
        return nameEn.contains(query.toLowerCase()) ||
            nameTh.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // <-- SEE HERE
        ),
        toolbarHeight: 80,
        backgroundColor: Color(0xff5C6795),
        centerTitle: true,
        title: Text(
          'ตำบล',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0xffD7CDAF),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (query) {
                    search(query);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ค้นหาตำบลใน${_amphure_name}',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final item = searchResults[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color(0xffE7E9EE),
                    child: ListTile(
                      title: Text(
                        item['name_th'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        item['name_en'],
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
