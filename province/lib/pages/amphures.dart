import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:province/pages/tambons.dart';

class AmphuresPage extends StatefulWidget {
  final province_id, province_name;
  const AmphuresPage({super.key, this.province_id, this.province_name});

  @override
  State<AmphuresPage> createState() => _AmphuresPageState();
}

class _AmphuresPageState extends State<AmphuresPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  List<dynamic> amphures = [];
  var _province_id, _province_name;

  Future<void> loadAmphures() async {
    final String jsonData =
        await rootBundle.loadString('assets/thai_amphures.json');
    final Map<String, dynamic> jsonDataMap = json.decode(jsonData);
    final List<dynamic> records = jsonDataMap['RECORDS'];
    setState(() {
      amphures =
          records.where((item) => item['province_id'] == _province_id).toList();
      searchResults = amphures;
    });
  }

  void search(String query) {
    setState(() {
      searchResults = amphures.where((item) {
        final nameEn = item['name_en'].toLowerCase();
        final nameTh = item['name_th'].toLowerCase();
        return nameEn.contains(query.toLowerCase()) ||
            nameTh.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAmphures();
    _province_id = widget.province_id;
    _province_name = widget.province_name;
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
          'อำเภอ',
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
                    hintText: 'ค้นหาอำเภอใน${_province_name}',
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TambonsPage(
                                  amphure_id: item['id'],
                                  amphure_name: item['name_th'])),
                        );
                      },
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
