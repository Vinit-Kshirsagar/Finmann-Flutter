import 'package:uuid/uuid.dart';
import '../datasources/local_database.dart';
import '../models/transaction_model.dart';
import 'i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  final _uuid = const Uuid();

  @override
  Future<List<TransactionModel>> getAll(String userId, {int? limit, int? offset}) async {
    final db = await LocalDatabase.database;
    final rows = await db.query(
      'transactions',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
      limit: limit,
      offset: offset,
    );
    return rows.map(TransactionModel.fromMap).toList();
  }

  @override
  Future<List<TransactionModel>> getByMonth(
      String userId, int year, int month) async {
    final db = await LocalDatabase.database;
    final start = DateTime(year, month, 1).toIso8601String();
    final end = DateTime(year, month + 1, 1).toIso8601String();
    final rows = await db.query(
      'transactions',
      where: 'user_id = ? AND date >= ? AND date < ?',
      whereArgs: [userId, start, end],
      orderBy: 'date DESC',
    );
    return rows.map(TransactionModel.fromMap).toList();
  }

  @override
  Future<TransactionModel> add({
    required String userId,
    required TransactionType type,
    required double amount,
    required String category,
    String? description,
    required DateTime date,
  }) async {
    final db = await LocalDatabase.database;
    final tx = TransactionModel(
      id: _uuid.v4(),
      userId: userId,
      type: type,
      amount: amount,
      category: category,
      description: description,
      date: date,
      createdAt: DateTime.now(),
    );
    await db.insert('transactions', tx.toMap());
    return tx;
  }

  @override
  Future<void> update(TransactionModel tx) async {
    final db = await LocalDatabase.database;
    await db.update(
      'transactions',
      tx.toMap(),
      where: 'id = ?',
      whereArgs: [tx.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    final db = await LocalDatabase.database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Map<String, double>> getCategoryTotals(
      String userId, int year, int month) async {
    final txns = await getByMonth(userId, year, month);
    final Map<String, double> totals = {};
    for (final t in txns) {
      if (t.isExpense) {
        totals[t.category] = (totals[t.category] ?? 0) + t.amount;
      }
    }
    return totals;
  }
}
