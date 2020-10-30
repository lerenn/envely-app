import 'package:Envely/logic/models/models.dart';

abstract class EnvelopsRepository {
  Future<void> createEnvelop(Budget budget, Category category, Envelop envelop);
  Stream<List<Envelop>> getEnvelops(Budget budget, Category category);
  Future<void> updateEnvelop(Budget budget, Category category, Envelop envelop);
  Future<void> deleteEnvelop(Budget budget, Category category, Envelop envelop);
}
