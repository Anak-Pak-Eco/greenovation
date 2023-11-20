//
//  HistoryGraphView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 15/11/23.
//

import SwiftUI
import Charts

struct HistoryGraphView: View {
    
    let items: [DeviceHistoryModel]
    
    var body: some View {
        let curColor = Color.primaryAccent
        let curGradient = LinearGradient(
            gradient: SwiftUI.Gradient (
                colors: [
                    curColor.opacity(0.7),
                    curColor.opacity(0.5),
                    curColor.opacity(0.25),
                    curColor.opacity(0.05),
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        
        if #available(iOS 16.0, *) {
            Chart(items) { item in
                LineMark(
                    x: .value("Hours", item.created_at.formatToHour),
                    y: .value("Value", item.current_ppm)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color(uiColor: UIColor.primaryAccent)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .interpolationMethod(.catmullRom)
                
                AreaMark(
                    x: .value("Hours", item.created_at.formatToHour),
                    y: .value("Value", item.current_ppm)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(curGradient)
            }
            .chartYScale(domain: 0...2000)
            .chartYAxis {
                AxisMarks(position: .trailing) { _ in
                    AxisValueLabel()
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisValueLabel()
                }
            }
            .frame(height: 200)
            .padding()
        } else {
            Text("Chart not available")
        }
    }
}

extension Date {
    var formatToHour: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

#Preview {
    HistoryGraphView(
        items: [
            .init(current_ph: 2, created_at: Date.now + 3600, serial_number: "20202020200", current_ppm: 1000),
            .init(current_ph: 50, created_at: Date() + 7200, serial_number: "20202020200", current_ppm: 1200),
            .init(current_ph: 80, created_at: Date() + 10800, serial_number: "20202020200", current_ppm: 1300)]
    )
        .frame(height: 200)
}
