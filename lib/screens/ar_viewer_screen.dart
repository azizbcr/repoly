import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'; // AR için bu paketi kullanabiliriz

class ARViewerScreen extends StatefulWidget {
  final Polymer polymer;

  const ARViewerScreen({super.key, required this.polymer});

  @override
  State<ARViewerScreen> createState() => _ARViewerScreenState();
}

class _ARViewerScreenState extends State<ARViewerScreen> {
  ArCoreController? arController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.polymer.name} 3D Görünüm'),
        backgroundColor: Colors.black,
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arController = controller;
    _addPolymerModel();
  }
}
