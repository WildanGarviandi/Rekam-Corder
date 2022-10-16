import 'package:flutter/material.dart';
import 'package:rekam_corder/components/list_item.dart';
import 'package:rekam_corder/data/recorded.dart';
import 'package:rekam_corder/data/storage.dart';

class MainRecord extends StatefulWidget {
  MainRecord({super.key});

  @override
  _MainRecord createState() => _MainRecord();
}

class _MainRecord extends State<MainRecord> {
  late List<ListItem> listWidget;

  @override
  void initState() {
    super.initState();
    Storage.instance.openDB();
  }

  @override
  void dispose() {
    Storage.instance.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorder'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Storage.instance.saveRecord(
                Recorded(
                    recordId: 0,
                    title: 'Percobaan',
                    date: DateTime.now().toString(),
                    length: '07:30'),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 100),
              shadowColor: Colors.black12,
              shape: const CircleBorder(),
              backgroundColor: Colors.amberAccent,
            ),
            child: const Text('Rec.'),
          ),
          FutureBuilder(
            future: Storage.instance.getAllListRecord(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                      return ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].date),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
