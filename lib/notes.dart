import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Map<String, String>> _notes = [];
  bool _isSortedNewest = true; // Default sorting (terbaru di atas)

  void _addNote() {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      setState(() {
        _notes.add({
          'title': _titleController.text,
          'content': _contentController.text,
        });
        _titleController.clear();
        _contentController.clear();
        _sortNotes(); // Pastikan sorting langsung diperbarui
      });
    }
  }

  void _toggleSorting() {
    setState(() {
      _isSortedNewest = !_isSortedNewest;
      _sortNotes();
    });
  }

  void _sortNotes() {
    setState(() {
      if (_isSortedNewest) {
        _notes = List.from(_notes.reversed); // Balik urutan catatan
      } else {
        _notes = List.from(_notes); // Biarkan dalam urutan asli
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'NOTES.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isSortedNewest ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: _toggleSorting,
            tooltip: _isSortedNewest ? 'Tampilkan Terlama' : 'Tampilkan Terbaru',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Masukkan Judul Catatan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _contentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Masukkan Isi Catatan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                    child: Text(
                      'KIRIM',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _notes[index]['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              _notes[index]['content']!,
                              style: TextStyle(fontSize: 14, color: Colors.white),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
