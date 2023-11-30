import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({Key? key, this.path}) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();

}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manual"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
            false,
            // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              debugPrint(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              debugPrint('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              debugPrint('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              //debugPrint('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
              ? const Center(child: CircularProgressIndicator())
              : Container()
              : Center(child: Text(errorMessage))
            ],
          ),

      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.extended(
                    heroTag: 'btn1',
                    label: Text(
                        (currentPage!)>0
                            ? "Ir para ${currentPage!}"
                            : "Em ${currentPage!+1}"
                    ),
                    onPressed:
                    (currentPage!)>0
                        ? () async {
                      await snapshot.data!.setPage(currentPage!-1);}
                        : null
                ),
                //const SizedBox(width: 30, height: 10),
                FloatingActionButton.extended(
                    heroTag: 'btn2',
                    label: Text(
                        (currentPage! < pages!-1)
                            ? "Ir para ${currentPage!+2}"
                            : "Em ${currentPage!+1}"
                    ),
                    onPressed:
                    (currentPage! < pages!-1)
                        ? () async {
                      await snapshot.data!.setPage(currentPage!+1);}
                        : null
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
