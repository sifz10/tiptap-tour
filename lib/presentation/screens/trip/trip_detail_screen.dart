import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/trip_providers.dart';
import 'package:tiptap_tour/presentation/screens/expense/expense_list_view.dart';
import 'package:tiptap_tour/presentation/screens/balance/balance_view.dart';
import 'package:tiptap_tour/presentation/screens/chat/chat_view.dart';
import 'package:tiptap_tour/presentation/screens/trip/members_view.dart';

class TripDetailScreen extends ConsumerWidget {
  final String tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripByIdProvider(tripId));

    return tripAsync.when(
      data: (trip) {
        if (trip == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Trip not found')),
          );
        }
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  if (trip.description != null &&
                      trip.description!.isNotEmpty)
                    Text(
                      trip.description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {},
                ),
              ],
              bottom: TabBar(
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
                indicatorSize: TabBarIndicatorSize.label,
                dividerHeight: 0,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.receipt_long_rounded, size: 20),
                    text: 'Expenses',
                  ),
                  Tab(
                    icon: Icon(Icons.balance_rounded, size: 20),
                    text: 'Balances',
                  ),
                  Tab(
                    icon: Icon(Icons.chat_bubble_outline_rounded, size: 20),
                    text: 'Chat',
                  ),
                  Tab(
                    icon: Icon(Icons.people_outline_rounded, size: 20),
                    text: 'Members',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ExpenseListView(
                    tripId: tripId, currency: trip.baseCurrency),
                BalanceView(
                    tripId: tripId, currency: trip.baseCurrency),
                ChatView(tripId: tripId),
                MembersView(tripId: tripId),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
