import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../constants.dart';
import 'chain_dialog.dart';
import 'login_dialog.dart';
import 'signup_dialog.dart';
import 'setting_dialog.dart';
import 'token_trade_page.dart';

// 数据模型，用于表示榜单中的每个项目
class TokenInfo {
  final String iconUrl;
  final String name;
  final String fullName;
  final String age;
  final String address;
  final int userCount;
  final double price;
  final int txCount;
  final String volume;
  final String marketCap;
  final double percentage1;
  final double percentage2;
  final bool isRun;
  final int otherCount;
  final double progress;

  TokenInfo({
    required this.iconUrl,
    required this.name,
    required this.fullName,
    required this.age,
    required this.address,
    required this.userCount,
    required this.price,
    required this.txCount,
    required this.volume,
    required this.marketCap,
    required this.percentage1,
    required this.percentage2,
    required this.otherCount,
    required this.progress,
    this.isRun = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _tabs = ["Trenches", "New Coins", "Hot", "Copy Trading", "Monitor", "Track", "Positions"];
  int _selectedTabIndex = 0; // 添加选中Tab索引
  TokenInfo? _selectedToken;

  final _chainSelectorKey = GlobalKey();
  final _settingsButtonKey = GlobalKey();
  late ChainInfo _selectedChain;

  // 基于截图的模拟数据
  final List<TokenInfo> _tokenList = [
    TokenInfo(
      iconUrl: 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/bitcoin/info/logo.png',
      name: 'CUPSE...',
      fullName: 'LIVE SAYING CUPSEY TI...',
      age: '2s',
      address: 'smSQz...ump',
      userCount: 7,
      price: 0.0017,
      txCount: 6,
      volume: 'V \$475.6',
      marketCap: 'MC \$4.8K',
      percentage1: 13.6,
      percentage2: 7,
      otherCount: 1,
      progress: 0.5,
    ),
    TokenInfo(
      iconUrl: 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png',
      name: 'BTCMO...',
      fullName: 'Bitcoinmoon',
      age: '7s',
      address: 'Dun3f...ump',
      userCount: 10,
      price: 0.0464,
      txCount: 7,
      volume: 'V \$6.69',
      marketCap: 'MC \$29.9K',
      percentage1: 100,
      percentage2: 0,
      otherCount: 6,
      progress: 0.9,
    ),
    TokenInfo(
      iconUrl: 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/binance/info/logo.png',
      name: 'NASTI...',
      fullName: 'Dog Of War',
      age: '11s',
      address: '23NbX...ump',
      userCount: 7,
      price: 0.10,
      txCount: 24,
      volume: 'V \$4.2K',
      marketCap: 'MC \$5.4K',
      percentage1: 19.6,
      percentage2: 27,
      isRun: true,
      otherCount: 8,
      progress: 0.3,
    ),
    TokenInfo(
      iconUrl: '	https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/0xdAC17F958D2ee523a2206206994597C13D831ec7/logo.png',
      name: 'GRO',
      fullName: 'Grobagana',
      age: '16s',
      address: 'FVDWD...ump',
      userCount: 5,
      price: 0.0014,
      txCount: 6,
      volume: 'V \$517.5',
      marketCap: 'MC \$4.3K',
      percentage1: 5.8,
      percentage2: 0.8,
      otherCount: 3,
      progress: 0.4,
    ),
    TokenInfo(
      iconUrl: '	https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/solana/info/logo.png',
      name: 'MAI',
      fullName: 'Memes As Icons',
      age: '17s',
      address: 'AJoDS...',
      userCount: 19,
      price: 0.041,
      txCount: 42,
      volume: 'V \$5.1K',
      marketCap: 'MC \$4.9K',
      percentage1: 18.2,
      percentage2: 22,
      isRun: true,
      otherCount: 7,
      progress: 0.8,
    ),
     TokenInfo(
      iconUrl: '	https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/0x7d1afa7b718fb893db30a3abc0cfc608aacfebb0/logo.png',
      name: 'ETF',
      fullName: 'ETF',
      age: '19s',
      address: 'CXYoT...ump',
      userCount: 3,
      price: 0.00033,
      txCount: 4,
      volume: 'V \$421.3',
      marketCap: 'MC \$4.4K',
      percentage1: 6.4,
      percentage2: 5,
      otherCount: 3,
      progress: 0.6,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedChain = ChainInfo(
        name: 'SOL',
        iconUrl:
            'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/solana/info/logo.png');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _selectedToken != null ? _buildBottomNav() : null,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 500;
    
    return AppBar(
      backgroundColor: const Color(0xFF131313),
      elevation: 0,
      leading: _selectedToken != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                setState(() {
                  _selectedToken = null;
                });
              },
            )
          : null,
      titleSpacing: _selectedToken != null ? 0 : 16.0,
      title: GestureDetector(
        key: _chainSelectorKey,
        onTap: () {
          SmartDialog.showAttach(
            targetContext: _chainSelectorKey.currentContext,
            alignment: Alignment.bottomLeft,
            builder: (context) {
              return ChainDialog(
                selectedChain: _selectedChain,
                onChainSelected: (chain) {
                  setState(() {
                    _selectedChain = chain;
                  });
                  SmartDialog.dismiss();
                },
              );
            },
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              _selectedChain.iconUrl,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.currency_bitcoin, size: 16, color: Colors.white),
                );
              },
            ),
            const SizedBox(width: 8),
            Text(_selectedChain.name, style: const TextStyle(color: Colors.white, fontSize: 14)),
            const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.white),
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
        IconButton(
          key: _settingsButtonKey,
          onPressed: () {
            SmartDialog.showAttach(
              targetContext: _settingsButtonKey.currentContext,
              alignment: Alignment.bottomRight,
              builder: (context) {
                return const SettingDialog();
              },
            );
          },
          icon: const Icon(Icons.hexagon_outlined, color: Colors.white),
          iconSize: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: isSmallScreen ? 2 : 4),
          child: OutlinedButton(
            onPressed: () {
              SmartDialog.show(
                alignment: Alignment.center,
                builder: (_) => const SignUpDialog(),
              );
            },
            child: Text('Sign up'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.grey[700]!),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 12),
              minimumSize: Size(isSmallScreen ? 50 : 60, 36),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: isSmallScreen ? 2 : 4),
          child: ElevatedButton(
            onPressed: () {
              SmartDialog.show(
                alignment: Alignment.center,
                builder: (_) => const LoginDialog(),
              );
            },
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 12),
              minimumSize: Size(isSmallScreen ? 50 : 60, 36),
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
      bottom: _selectedToken == null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _tabs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final tabName = entry.value;
                      final isSelected = index == _selectedTabIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.grey[800]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tabName,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[400],
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_selectedToken != null) {
      return TokenTradePage(token: _selectedToken!);
    }

    return IndexedStack(
      index: _selectedTabIndex,
      children: [
        _buildTokenListTab(context), // 第一个Tab
        ...List.generate(_tabs.length - 1, (index) => _buildPlaceholderTab(_tabs[index + 1])),
      ],
    );
  }

  Widget _buildTokenListTab(BuildContext context) {
    return Column(
      children: [
        _buildFilterBar(context),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: _tokenList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 1),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedToken = _tokenList[index];
                  });
                },
                child: _buildTokenListItem(_tokenList[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 350;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          if (!isVerySmallScreen) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.new_releases, color: Colors.greenAccent, size: 14),
                  SizedBox(width: 4),
                  Text('New', style: TextStyle(color: Colors.white, fontSize: 12)),
                  SizedBox(width: 2),
                  Icon(Icons.keyboard_arrow_down, size: 16),
                ],
              ),
            ),
            const SizedBox(width: 4),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Ξ 0',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
          if (!isVerySmallScreen) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'P1',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ],
          const Spacer(),
          Expanded(
            child: SizedBox(
              height: 32,
              child: TextField(
                style: const TextStyle(fontSize: 11, color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 11),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.search, size: 14, color: Colors.white),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minHeight: 14,
                    minWidth: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[900],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.filter_list_alt, size: 20),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenListItem(TokenInfo token) {
    Color positiveColor = Colors.greenAccent[400]!;
    Color negativeColor = Colors.redAccent[200]!;

    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(token.iconUrl),
              radius: 25,
              onBackgroundImageError: (exception, stackTrace) {
                // 图片加载失败时的处理
              },
              child: token.iconUrl.isEmpty 
                ? const Icon(Icons.image, color: Colors.grey)
                : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          token.name, 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          token.fullName,
                          style: TextStyle(color: Colors.grey[400]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(token.age, style: TextStyle(color: positiveColor, fontSize: 12)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          token.address, 
                          style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.copy_all_outlined, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Icon(Icons.search, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 8),
                      Icon(Icons.person_outline, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 2),
                      Text(
                        '${token.userCount}', 
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.arrow_upward, size: 12, color: positiveColor),
                      Flexible(
                        child: Text(
                          '${token.percentage1}%', 
                          style: TextStyle(color: positiveColor, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_downward, size: 12, color: negativeColor),
                      Flexible(
                        child: Text(
                          '${token.percentage2}%', 
                          style: TextStyle(color: negativeColor, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (token.isRun) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('Run', style: TextStyle(color: Colors.pinkAccent, fontSize: 10)),
                        ),
                      ],
                      const SizedBox(width: 8),
                      Icon(Icons.whatshot_outlined, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 2),
                      Text(
                        '${token.otherCount}', 
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.sync_outlined, color: positiveColor, size: 20),
                  const SizedBox(height: 4),
                  Text(
                    '0.${token.price.toString().split('.').last} TX ${token.txCount}', 
                    style: TextStyle(color: Colors.grey[300], fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    token.volume, 
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    token.marketCap, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: token.progress,
                      backgroundColor: negativeColor,
                      valueColor: AlwaysStoppedAnimation<Color>(positiveColor),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab(String tabName) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            tabName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '功能开发中...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: Colors.black,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.flash_on, color: Colors.white),
                label: const Text('Buy'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sell_outlined, color: Colors.white),
                label: const Text('Sell'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_outline, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
} 