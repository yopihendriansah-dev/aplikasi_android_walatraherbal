import 'package:flutter/foundation.dart';

import '../models/address.dart';
import 'local_storage.dart';

class AddressManager {
  static final ValueNotifier<List<Address>> addresses =
      ValueNotifier<List<Address>>([]);

  static final LocalStorage storage = LocalStorage();

  static Future<void> load() async {
    addresses.value = await storage.loadAddresses();
  }

  static Future<void> add(Address address) async {
    var updatedAddresses = [...addresses.value];
    if (address.isDefault || updatedAddresses.isEmpty) {
      updatedAddresses = updatedAddresses.map((item) {
        return item.copyWith(isDefault: false);
      }).toList();

      address = address.copyWith(isDefault: true);
    }

    updatedAddresses.add(address);
    addresses.value = updatedAddresses;

    await storage.saveAddresses(updatedAddresses);
  }

  static Future<void> delete(String id) async {
    final updateAddresses = addresses.value
        .where((address) => address.id != id)
        .toList();

    addresses.value = updateAddresses;

    await storage.saveAddresses(updateAddresses);
  }

  static Future<void> setDefault(String id) async {
    final updateAddresses = addresses.value.map((address) {
      return address.copyWith(isDefault: address.id == id);
    }).toList();

    addresses.value = updateAddresses;
    await storage.saveAddresses(updateAddresses);
  }

  static Address? get defaultAddress {
    for (final address in addresses.value) {
      if (address.isDefault) {
        return address;
      }
    }
    return null;
  }
}
