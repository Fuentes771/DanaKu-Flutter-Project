import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces.dart';
import '../models/transaction.dart';

class FirebaseTransactionsRepository implements ITransactionsRepository {
  final FirebaseFirestore _db;
  final String _userId;
  FirebaseTransactionsRepository(this._db, this._userId);

  CollectionReference<Map<String, dynamic>> get _col => _db.collection('users').doc(_userId).collection('transactions');

  @override
  Future<List<AppTransaction>> getAll() async {
    final snap = await _col.get();
    return snap.docs.map((d) => AppTransaction.fromJson(d.data())).toList();
  }

  @override
  Future<void> saveAll(List<AppTransaction> txs) async {
    final batch = _db.batch();
    final existing = await _col.get();
    for (final doc in existing.docs) {
      batch.delete(doc.reference);
    }
    for (final t in txs) {
      batch.set(_col.doc(t.id), t.toJson());
    }
    await batch.commit();
  }
}
