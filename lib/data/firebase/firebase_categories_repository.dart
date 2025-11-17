import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces.dart';
import '../models/category.dart';

class FirebaseCategoriesRepository implements ICategoriesRepository {
  final FirebaseFirestore _db;
  final String _userId;
  FirebaseCategoriesRepository(this._db, this._userId);

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('users').doc(_userId).collection('categories');

  @override
  Future<List<AppCategory>> getAll() async {
    final snap = await _col.get();
    return snap.docs.map((d) => AppCategory.fromJson(d.data())).toList();
  }

  @override
  Future<void> saveAll(List<AppCategory> categories) async {
    final batch = _db.batch();
    final existing = await _col.get();
    for (final doc in existing.docs) {
      batch.delete(doc.reference);
    }
    for (final c in categories) {
      batch.set(_col.doc(c.id), c.toJson());
    }
    await batch.commit();
  }

  @override
  Future<void> ensureDefaults() async {
    final items = await getAll();
    if (items.isNotEmpty) return;
    final defaults = <AppCategory>[
      AppCategory(id: 'exp_food', name: 'Makanan', type: CategoryType.expense),
      AppCategory(
        id: 'exp_transport',
        name: 'Transportasi',
        type: CategoryType.expense,
      ),
      AppCategory(
        id: 'exp_shopping',
        name: 'Belanja',
        type: CategoryType.expense,
      ),
      AppCategory(id: 'inc_salary', name: 'Gaji', type: CategoryType.income),
      AppCategory(id: 'inc_other', name: 'Lainnya', type: CategoryType.income),
    ];
    await saveAll(defaults);
  }
}
