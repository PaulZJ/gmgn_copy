import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'home_page.dart';

class TokenTradePage extends StatefulWidget {
  final TokenInfo token;

  const TokenTradePage({Key? key, required this.token}) : super(key: key);

  @override
  State<TokenTradePage> createState() => _TokenTradePageState();
}

class _TokenTradePageState extends State<TokenTradePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Note: This page doesn't have its own Scaffold. It's rendered inside HomePage's Scaffold body.
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTokenHeader(),
            const SizedBox(height: 16),
            _buildFilterBar(),
            const SizedBox(height: 16),
            _buildTimeFrameSelector(),
            const SizedBox(height: 8),
            _buildChart(),
            const SizedBox(height: 16),
            _buildInfoTabs(),
            _buildActivityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(widget.token.iconUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('TNC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(width: 4),
                  Icon(Icons.warning_amber_rounded, color: Colors.red, size: 16),
                  const SizedBox(width: 4),
                  Icon(Icons.ac_unit, color: Colors.green, size: 16),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'VQRX7...ump',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                   const SizedBox(width: 4),
                  Icon(Icons.copy_all_outlined, size: 12, color: Colors.grey[500]),
                ],
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$0.0₅53506', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('8s', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                const SizedBox(width: 8),
                Text('31.7%', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
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
            )
          ],
        ),
        const SizedBox(width: 8),
        Icon(Icons.share, color: Colors.white, size: 20),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              style: const TextStyle(fontSize: 11, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Name or CA',
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
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text('7/11', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.local_gas_station, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              Text('0%', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Placeholder for the checkmarks
        Row(
          children: List.generate(4, (index) => Icon(Icons.check_circle, color: Colors.green, size: 20)),
        ),
      ],
    );
  }

  Widget _buildTimeFrameSelector() {
    final List<String> timeFrames = ['1m', '5m', '1h', '24h'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...timeFrames.map((frame) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('+36.85%', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
        )),
        Icon(Icons.keyboard_arrow_down, color: Colors.white),
      ],
    );
  }

  Widget _buildChart() {
    final List<charts.Series<dynamic, num>> seriesList = [
      charts.Series<ChartData, int>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (ChartData sales, _) => sales.time,
        measureFn: (ChartData sales, _) => sales.price,
        data: [
          ChartData(0, 50000),
          ChartData(1, 52000),
          ChartData(2, 60000),
          ChartData(3, 55000),
          ChartData(4, 53506),
          ChartData(5, 54000),
          ChartData(6, 48000),
          ChartData(7, 45000),
        ],
      )
    ];

    return Container(
      height: 250,
      child: charts.LineChart(
        seriesList,
        animate: true,
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize: 10,
              color: charts.MaterialPalette.gray.shade400,
            ),
            lineStyle: charts.LineStyleSpec(
              color: charts.MaterialPalette.gray.shade800,
            ),
          ),
        ),
        domainAxis: charts.NumericAxisSpec(
           renderSpec: charts.NoneRenderSpec(),
        ),
      ),
    );
  }

  Widget _buildInfoTabs() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Activity'),
            Tab(text: 'Liquidity'),
            Tab(text: 'Traders'),
            Tab(text: 'Holders 9'),
            Tab(text: 'Tracking'),
          ],
        ),
        SizedBox(
          height: 200, // Adjust height as needed
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildActivityList(),
              Center(child: Text('Liquidity Info', style: TextStyle(color: Colors.white))),
              Center(child: Text('Traders Info', style: TextStyle(color: Colors.white))),
              Center(child: Text('Holders Info', style: TextStyle(color: Colors.white))),
              Center(child: Text('Tracking Info', style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityList() {
    // This is a simplified version based on the screenshot
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildActivityHeader(),
        _buildActivityRow('8s', 'Buy', '\$0.0₃13566', '26.6M'),
        _buildActivityRow('8s', 'Buy', '\$32.76', '6.5M'),
      ],
    );
  }

  Widget _buildActivityHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderItem('Age', hasIcon: true),
          _buildHeaderItem('Type', hasIcon: true),
          _buildHeaderItem('Total USD', hasIcon: true),
          _buildHeaderItem('Amount', hasIcon: false),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(String title, {bool hasIcon = false}) {
    return Row(
      children: [
        Text(title, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        if (hasIcon) const SizedBox(width: 4),
        if (hasIcon) Icon(Icons.filter_list, size: 14, color: Colors.grey[400]),
      ],
    );
  }

  Widget _buildActivityRow(String age, String type, String totalUsd, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(age, style: TextStyle(color: Colors.white, fontSize: 12)),
          Text(type, style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text(totalUsd, style: TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(width: 4),
              Icon(Icons.gpp_good, color: Colors.blue, size: 14),
            ],
          ),
          Text(amount, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

class ChartData {
  final int time;
  final double price;

  ChartData(this.time, this.price);
} 