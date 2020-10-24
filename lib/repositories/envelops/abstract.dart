import 'package:Envely/models/models.dart';

abstract class EnvelopsRepository {
  Future<void> createEnvelop(Budget budget, Envelop envelop);
  Stream<List<Envelop>> getEnvelops(Budget budget);
  Future<void> updateEnvelop(Budget budget, Envelop envelop);
  Future<void> deleteEnvelop(Budget budget, Envelop envelop);
}
