import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cost_share/model/budget.dart';

abstract class BudgetRepository {
  Future<Budget> addBudget(Budget budget);
  Future<void> deleteBudget(String budgetId);
  Future<List<Budget>> getGroupBudgets(String groupId);
}

class BudgetRepositoryImpl extends BudgetRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Budget> addBudget(Budget budget) async {
    try {
      DocumentReference budgetRef =
          await _firestore.collection('budgets').add(budget.toJson());
      return budget.copyWith(id: budgetRef.id);
    } catch (e) {
      throw Exception('Failed to add budget: $e');
    }
  }

  @override
  Future<void> deleteBudget(String budgetId) async {
    try {
      await _firestore.collection('budgets').doc(budgetId).delete();
    } catch (e) {
      throw Exception('Failed to delete budget: $e');
    }
  }

  @override
  Future<List<Budget>> getGroupBudgets(String groupId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> budgetSnapshot = await _firestore
          .collection('budgets')
          .where('groupId', isEqualTo: groupId)
          .get();

      return budgetSnapshot.docs
          .map((doc) => Budget.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch budgets: $e');
    }
  }
}