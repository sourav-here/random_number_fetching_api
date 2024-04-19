import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:random_num_api/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _randomNumber;

  Future<void> _fetchRandomNumber(BuildContext context) async {
    Provider.of<RandomNumberProvider>(context, listen: false).setLoading(true);
    final response = await http.get(Uri.parse(
        'https://www.random.org/integers/?num=1&min=1&max=100&col=1&base=10&format=plain&rnd=new'));

    if (response.statusCode == 200) {
      setState(() {
        _randomNumber = int.parse(response.body);
      });
    } else {
      Navigator.pushReplacementNamed(context, '/error');
    }
    Provider.of<RandomNumberProvider>(context, listen: false).setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number Generator'),
      ),
      body: Center(
        child: Consumer<RandomNumberProvider>(
          builder: (context, randomNumberProvider, _) {
            return randomNumberProvider.isLoading
                ? CircularProgressIndicator()
                : (_randomNumber != null
                    ? Text(
                        'Random Number: $_randomNumber',
                        style: TextStyle(fontSize: 24),
                      )
                    : Text('Failed to fetch random number from API.'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _fetchRandomNumber(context),
        tooltip: 'Generate Random Number',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
