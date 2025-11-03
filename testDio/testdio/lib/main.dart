import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DioPracticeApp());
}

class DioPracticeApp extends StatelessWidget {
  const DioPracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Practice UI',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.lightBlueAccent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const DioHomePage(),
    );
  }
}

class DioHomePage extends StatefulWidget {
  const DioHomePage({super.key});

  @override
  State<DioHomePage> createState() => _DioHomePageState();
}

class _DioHomePageState extends State<DioHomePage> {
  String responseText = '';
  bool isLoading = false;
  Dio dio = Dio();

  void getRequest() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );
      setState(() {
        responseText = response.data.toString();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        responseText = 'Error: $e';
        isLoading = false;
      });
    }
  }

  void postRequest() async {
    // TODO: implement POST request
  }

  void putRequest() async {
    // TODO: implement PUT request
  }

  void patchRequest() async {
    // TODO: implement PATCH request
  }

  void deleteRequest() async {
    // TODO: implement DELETE request
  }

  void headRequest() async {
    // TODO: implement HEAD request
  }

  void downloadRequest() async {
    // TODO: implement DOWNLOAD request
  }

  Widget _buildButton(String title, VoidCallback onPressed, {Color? color}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Practice Playground'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildButton(
                      'GET Request',
                      getRequest,
                      color: Colors.greenAccent[400],
                    ),
                    _buildButton(
                      'POST Request',
                      postRequest,
                      color: Colors.blueAccent,
                    ),
                    _buildButton(
                      'PUT Request',
                      putRequest,
                      color: Colors.orangeAccent,
                    ),
                    _buildButton(
                      'PATCH Request',
                      patchRequest,
                      color: Colors.purpleAccent,
                    ),
                    _buildButton(
                      'DELETE Request',
                      deleteRequest,
                      color: Colors.redAccent,
                    ),
                    _buildButton(
                      'HEAD Request',
                      headRequest,
                      color: Colors.tealAccent[400],
                    ),
                    _buildButton(
                      'DOWNLOAD File',
                      downloadRequest,
                      color: Colors.indigoAccent,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Text(
                          responseText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontSize: 14,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
