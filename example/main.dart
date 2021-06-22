import 'package:bitbox/bitbox.dart' as Bitbox;

void main() async {
  // set this to false to use mainnet
  final testnet = true;

  // After running the code for the first time, depositing an amount to the address displayed in the console,
  // and waiting for confirmation, paste the generated mnemonic here,
  // so the code continues below with address withdrawal
  String mnemonic = "";

  if (mnemonic == "") {
    // generate 12-word (128bit) mnemonic
    mnemonic = Bitbox.Mnemonic.generate();

    print(mnemonic);
  }

  // generate a seed from mnemonic
  final seed = Bitbox.Mnemonic.toSeed(mnemonic);

  // create an instance of Bitbox.HDNode for mainnet
  final masterNode = Bitbox.HDNode.fromSeed(seed, testnet);

  // This format is compatible with Bitcoin.com wallet.
  // Other wallets use Change to m/44'/145'/0'/0
  final accountDerivationPath = "m/44'/0'/0'/0";

  // create an account node using the provided derivation path
  final accountNode = masterNode.derivePath(accountDerivationPath);

  // get account's extended private key
  final accountXPriv = accountNode.toXPriv();

  // create a Bitbox.HDNode instance of the first child in this account
  final childNode = accountNode.derive(0);

  // get an address of the child
  final address = childNode.toCashAddress();

}
