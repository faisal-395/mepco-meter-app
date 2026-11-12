import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../domain/models.dart';
import 'report_pdf.dart';

/// Folder where a copy of every generated PDF is kept (included in backups).
Future<Directory> pdfDirectory() async {
  final docs = await getApplicationDocumentsDirectory();
  final dir = Directory(p.join(docs.path, 'pdfs'));
  if (!dir.existsSync()) dir.createSync(recursive: true);
  return dir;
}

/// The logo, if assets/mepco_logo.png was added to the app. Otherwise null.
Future<Uint8List?> loadLogo() async {
  try {
    final data = await rootBundle.load('assets/mepco_logo.png');
    return data.buffer.asUint8List();
  } catch (_) {
    return null;
  }
}

/// Print preview with Print (Wi-Fi printer / Save as PDF) and Share buttons.
class PdfScreen extends ConsumerStatefulWidget {
  const PdfScreen({super.key, required this.reportId, this.finalView = false});
  final int reportId;

  /// True when shown as the read-only view of a final report.
  final bool finalView;

  @override
  ConsumerState<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends ConsumerState<PdfScreen> {
  ReportBundle? _bundle;
  Uint8List? _bytes;
  File? _file;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _build();
  }

  Future<void> _build() async {
    try {
      final b = await ref.read(reportsDaoProvider).loadBundle(widget.reportId);
      if (b == null) throw StateError('Report not found');
      final settings = await ref.read(settingsDaoProvider).getAll();
      final bytes = await buildReportPdf(b, settings, logo: await loadLogo());
      final file = File(
        p.join((await pdfDirectory()).path, reportPdfFileName(b)),
      );
      await file.writeAsBytes(bytes, flush: true);
      if (!mounted) return;
      setState(() {
        _bundle = b;
        _bytes = bytes;
        _file = file;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _share() async {
    final f = _file;
    if (f == null) return;
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(f.path, mimeType: 'application/pdf')],
        subject: p.basename(f.path),
      ),
    );
  }

  Future<void> _duplicate() async {
    final id = await ref
        .read(reportsDaoProvider)
        .duplicateAsDraft(widget.reportId);
    if (mounted) context.pushReplacement('/reports/$id');
  }

  @override
  Widget build(BuildContext context) {
    final b = _bundle;
    final bytes = _bytes;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          b == null
              ? 'Report'
              : '${b.template.shortName}${b.isFinal ? ' (final)' : ' (draft)'}',
        ),
        actions: [
          if (bytes != null)
            IconButton(
              tooltip: 'Share (WhatsApp, email...)',
              icon: const Icon(Icons.share),
              onPressed: _share,
            ),
          if (widget.finalView && b != null)
            TextButton.icon(
              onPressed: _duplicate,
              icon: const Icon(Icons.copy),
              label: const Text('Duplicate as new draft'),
            ),
        ],
      ),
      body: bytes == null
          ? loadingOrError(_error)
          : Column(
              children: [
                if (_file != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Saved copy: ${p.basename(_file!.path)}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                Expanded(
                  child: PdfPreview(
                    build: (_) async => bytes,
                    pdfFileName: _file == null ? null : p.basename(_file!.path),
                    canChangePageFormat: false,
                    canChangeOrientation: false,
                    canDebug: false,
                    allowPrinting: true,
                    allowSharing: true,
                  ),
                ),
              ],
            ),
    );
  }
}
