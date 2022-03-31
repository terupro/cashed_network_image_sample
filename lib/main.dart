import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image_sample/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cached Network Image',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //キャッシュを削除し、再度読み込む
    void clearCache() {
      imageCache!.clear();
      imageCache!.clearLiveImages();
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached Network Image'),
        actions: [
          IconButton(
            onPressed: clearCache,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) => Card(
          color: Colors.white,
          child: GestureDetector(
            // ポップアップを表示する
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text('Image ${index + 1}'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context),
                      child: CachedNetworkImage(
                        key: UniqueKey(),
                        imageUrl:
                            'https://source.unsplash.com/random?sig=$index',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: 'https://source.unsplash.com/random?sig=$index',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Image ${index + 1}',
                style: const TextStyle(color: Colors.black),
              ),
              trailing: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
