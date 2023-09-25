import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:province/pages/amphures.dart';

class Province extends StatefulWidget {
  const Province({super.key});

  @override
  State<Province> createState() => _ProvinceState();
}

class _ProvinceState extends State<Province> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  List<dynamic> province = [];

  Future<void> loadProvince() async {
    final String jsonData = await DefaultAssetBundle.of(context)
        .loadString('assets/thai_provinces.json');
    // final String jsonData =
    //     await rootBundle.loadString('assets/thai_provinces');
    final Map<String, dynamic> jsonDataMap = json.decode(jsonData);
    final List<dynamic> records = jsonDataMap['RECORDS'];
    setState(() {
      province = records;
      searchResults = province;
    });
  }

  void search(String query) {
    setState(() {
      searchResults = province.where((item) {
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
    loadProvince();
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
          'จังหวัด',
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
                    hintText: 'ค้นหาจังหวัด',
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
                              builder: (context) => AmphuresPage(
                                    province_id: item['id'],
                                    province_name: item['name_th'],
                                  )),
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
                      // Add more widget properties or customize as needed
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
