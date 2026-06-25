import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Ajoute 'intl' à ton pubspec.yaml pour formater les dates
import '../providers/tryon_provider.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Chargement automatique au lancement
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tryOnProvider.notifier).fetchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(tryOnProvider.notifier);
    final tryOnState = ref.watch(tryOnProvider);

    return RefreshIndicator(
      onRefresh: () => notifier.fetchHistory(),
      child: tryOnState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifier.history.isEmpty
              ? const Center(child: Text("Aucun essayage pour l'instant"))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: notifier.history.length,
                  itemBuilder: (context, index) {
                    final item = notifier.history[index];
                    return Card(
                      child: ListTile(
                        leading: item.resultImageUrl != null 
                            ? ClipRRect(borderRadius: BorderRadius.circular(4), child: CachedNetworkImage(imageUrl: item.resultImageUrl!, width: 50, height: 50, fit: BoxFit.cover))
                            : const Icon(Icons.image_not_supported),
                        title: Text("Essayage du ${DateFormat('dd/MM/yyyy').format(item.createdAt)}"),
                        subtitle: Chip(
                          label: Text(item.status),
                          backgroundColor: item.status == 'completed' ? Colors.green.shade100 : Colors.orange.shade100,
                        ),
                        onTap: () {
                          // TODO: Naviguer vers résultat (nécessite de passer l'item au provider)
                          context.push('/result');
                        },
                      ),
                    );
                  },
                ),
    );
  }
}