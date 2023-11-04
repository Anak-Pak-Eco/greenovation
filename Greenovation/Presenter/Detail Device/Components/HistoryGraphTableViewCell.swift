//
//  HistoryGraphTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit
import DGCharts

class HistoryGraphTableViewCell: UITableViewCell {

    @IBOutlet weak var chartFrameView: UIView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    let dates = [
        Date(dateLiteralString: "2023-10-30"),
        Date().addingTimeInterval(3600 * 3),
        Date().addingTimeInterval(3600 * 6),
        Date().addingTimeInterval(3600 * 9),
        Date().addingTimeInterval(3600 * 12),
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initChart()
        chartFrameView.layer.cornerRadius = 10
    }
    
    private func initChart() {
        lineChartView.chartDescription.enabled = false
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = true
        lineChartView.leftAxis.enabled = false
        
        lineChartView.borderLineWidth = 0
        lineChartView.legend.form = .circle
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.drawBordersEnabled = false
        
        let rightAxis = lineChartView.rightAxis
        rightAxis.removeAllLimitLines()
        rightAxis.axisMaximum = 200
        rightAxis.gridLineDashLengths = [0]
        rightAxis.drawLimitLinesBehindDataEnabled = false
        rightAxis.drawGridLinesEnabled = false
        
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        
        setDataCount(5, range: 200)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let values = [
            ChartDataEntry(x: 2, y: 2),
            ChartDataEntry(x: 3, y: 3),
            ChartDataEntry(x: 4, y: 4),
        ]

        let dataSet = LineChartDataSet(entries: values)
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCircleHoleEnabled = false
        dataSet.isDrawLineWithGradientEnabled = false
        dataSet.label = nil
        dataSet.lineDashLengths = nil
        dataSet.highlightLineDashLengths = nil
        dataSet.gradientPositions = nil
        dataSet.setColor(.primaryAccent)
        dataSet.setCircleColor(.black)
        dataSet.lineWidth = 1
        dataSet.circleRadius = 0
        dataSet.valueFont = .systemFont(ofSize: 9)
        dataSet.formLineWidth = 0
        dataSet.formSize = 15
        dataSet.mode = LineChartDataSet.Mode.horizontalBezier

        let gradientColors = [
            UIColor.surfaceContainerHigh.cgColor,
            UIColor.primaryAccent.cgColor,
            UIColor.primaryAccent.cgColor
        ]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        dataSet.fillAlpha = 1
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        dataSet.drawFilledEnabled = true

        let data = LineChartData(dataSet: dataSet)

        lineChartView.data = data
    }
}

public class DateValueFormatter: NSObject, AxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "HH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
