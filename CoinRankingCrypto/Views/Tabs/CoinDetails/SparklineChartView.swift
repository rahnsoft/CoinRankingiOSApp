//
//  SparklineChartView.swift
//  CoinRankingCrypto
//
//  Created by Nick on 11/08/2025.
//


import UIKit
import DGCharts
import SnapKit

class SparklineChartView: UIView, ChartViewDelegate {
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .clear
        chartView.noDataText = "No data available"
        chartView.noDataTextColor = .label
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        
        chartView.legend.enabled = false
        chartView.delegate = self
        
        chartView.highlightPerTapEnabled = true
        chartView.highlightPerDragEnabled = false
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    
    private lazy var highlightLabel: UILabel = {
        let label = UILabel()
        label.font = .SBFont.medium.font(12)
        label.textColor = .label
        label.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var highlightCircle: UIView = {
        let circle = UIView()
        circle.backgroundColor = .systemOrange
        circle.layer.cornerRadius = 5
        circle.isHidden = true
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    
    private var chartEntries: [ChartDataEntry] = []
    private var symbol: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(lineChartView)
        addSubview(highlightCircle)
        addSubview(highlightLabel)
        
        lineChartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        highlightCircle.snp.makeConstraints { make in
            make.width.height.equalTo(10)
            make.centerX.equalTo(self.snp.left)
            make.centerY.equalTo(self.snp.top)
        }
        
        highlightLabel.snp.makeConstraints { make in
            make.bottom.equalTo(highlightCircle.snp.top).offset(-4)
            make.centerX.equalTo(highlightCircle.snp.centerX)
        }
    }
    
    func setSparklineData(_ sparklineValues: [Double], symbol: String) {
        chartEntries = sparklineValues.enumerated().map { index, val in
            ChartDataEntry(x: Double(index), y: val)
        }
        
        let dataSet = LineChartDataSet(entries: chartEntries)
        dataSet.colors = [.systemOrange]
        dataSet.drawCirclesEnabled = false
        dataSet.drawFilledEnabled = false
        dataSet.mode = .linear
        dataSet.lineWidth = 2.0
        
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        
        lineChartView.data = data
        
        self.symbol = symbol
        
        highlightLabel.isHidden = true
        highlightCircle.isHidden = true
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let index = chartEntries.firstIndex(where: { $0.x == entry.x && $0.y == entry.y }) else {
            return
        }
        
        let markerPoint = lineChartView.getPosition(entry: entry, axis: .left)
        
        highlightCircle.isHidden = false
        highlightCircle.snp.remakeConstraints { make in
            make.width.height.equalTo(10)
            make.centerX.equalToSuperview().offset(markerPoint.x - lineChartView.bounds.width / 2)
            make.centerY.equalToSuperview().offset(markerPoint.y - lineChartView.bounds.height / 2)
        }
        
        highlightLabel.isHidden = false
        highlightLabel.text = "\(symbol) \(String(format: "%.4f", entry.y))"
        
        highlightLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(highlightCircle.snp.top).offset(-4)
            make.centerX.equalTo(highlightCircle.snp.centerX)
        }
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        highlightCircle.isHidden = true
        highlightLabel.isHidden = true
    }
}
