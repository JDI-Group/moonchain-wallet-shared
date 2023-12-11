import 'dart:typed_data';

import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/web3dart.dart';

class MXCTransaction {
  static Transaction buildSpeedUpTransactionFromTransactionModel(
    TransactionModel toSpeedUpTransaction,
    Account account,
    EtherAmount maxFeePerGas,
    EtherAmount priorityFee,
  ) {
    // Sending to ourselves
    final fromAddress = EthereumAddress.fromHex(account.address);
    final toSpeedUpTransactionFrom =
        EthereumAddress.fromHex(toSpeedUpTransaction.from!);
    if (toSpeedUpTransactionFrom != fromAddress) {
      throw 'Cannot speed up a transaction that is not sent from this account';
    }
    final toAddress = EthereumAddress.fromHex(toSpeedUpTransaction.to!);

    // might or might not contain gas limit
    int? gasLimit = toSpeedUpTransaction.gasLimit;

    Uint8List? data;
    if (toSpeedUpTransaction.data != null &&
        toSpeedUpTransaction.data != '0x') {
      data = MXCType.hexToUint8List(toSpeedUpTransaction.data!);
    }

    // Making a copy transaction (Only for disposing other transaction(s))
    EtherAmount? value;
    final txType = toSpeedUpTransaction.type;
    // read the comments transferType property of TransactionModel 
    final transferType = toSpeedUpTransaction.transferType;
    // If It's a sent then It has coin transfer
    if (toSpeedUpTransaction.value != null && txType == TransactionType.sent && transferType != TransferType.erc20) {
      final valueInBigInt = MXCType.stringToBigInt(toSpeedUpTransaction.value!);
      value = EtherAmount.fromBigInt(EtherUnit.wei, valueInBigInt);
    }

    // Nonce is important since we are going to override this nonce transaction
    final int nonce = toSpeedUpTransaction.nonce!;

    return Transaction(
      to: toAddress,
      from: fromAddress,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: priorityFee,
      maxGas: gasLimit,
      value: value,
      nonce: nonce,
      data: data,
    );
  }

  static Transaction buildCancelTransactionFromTransactionModel(
    TransactionModel toCancelTransaction,
    Account account,
    EtherAmount maxFeePerGas,
    EtherAmount priorityFee,
  ) {
    // Sending to ourselves
    final fromAddress = EthereumAddress.fromHex(account.address);
    final toCancelTransactionFrom =
        EthereumAddress.fromHex(toCancelTransaction.from!);
    if (toCancelTransactionFrom != fromAddress) {
      throw 'Cannot cancel a transaction that is not sent from this account';
    }
    final toAddress = fromAddress;

    // Making a dump transaction (Only for disposing other transaction(s))
    EtherAmount value = EtherAmount.fromBigInt(EtherUnit.ether, BigInt.zero);

    // Nonce is important since we are going to override this nonce transaction
    final int nonce = toCancelTransaction.nonce!;

    return Transaction(
      to: toAddress,
      from: fromAddress,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: priorityFee,
      value: value,
      nonce: nonce,
    );
  }
}
