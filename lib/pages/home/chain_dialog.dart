import 'package:flutter/material.dart';

class ChainInfo {
  final String name;
  final String iconUrl;

  ChainInfo({required this.name, required this.iconUrl});
}

class ChainDialog extends StatelessWidget {
  final Function(ChainInfo) onChainSelected;
  final ChainInfo selectedChain;

  ChainDialog({
    super.key,
    required this.onChainSelected,
    required this.selectedChain,
  });

  final List<ChainInfo> _chains = [
    ChainInfo(
        name: 'SOL',
        iconUrl:
            'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/solana/info/logo.png'),
    ChainInfo(
        name: 'ETH',
        iconUrl:
            'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png'),
    ChainInfo(
        name: 'Base',
        iconUrl:
            'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/base/info/logo.png'),
    ChainInfo(
        name: 'BSC',
        iconUrl:
            'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/binance/info/logo.png'),
    ChainInfo(
        name: 'Tron',
        iconUrl:
            'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/tron/info/logo.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _chains.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final chain = _chains[index];
          final isSelected = chain.name == selectedChain.name;
          return GestureDetector(
            onTap: () => onChainSelected(chain),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.network(
                    chain.iconUrl,
                    height: 20,
                    width: 20,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    chain.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 2),
      ),
    );
  }
} 