//
//  HistoryGraphView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 15/11/23.
//

import SwiftUI
import Charts

struct Item: Identifiable {
    var id = UUID()
    let type: String
    let value: Double
}

struct HistoryGraphView: View {
    
    let items: [Item] = [
        Item(type: "00.00", value: 900 ),
        Item(type: "03.00", value: 1100 ),
        Item(type: "06.00", value: 500 ),
        Item(type: "09.00", value: 800 ),
        Item(type: "12.00", value: 600 ),
        Item(type: "15.00", value: 500 ),
        Item(type: "18.00", value: 1000 ),
    ]
    
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
                    x: .value("Month", item.type),
                    y: .value("Revenue", item.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.green],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .interpolationMethod(.catmullRom)
                
                AreaMark(
                    x: .value("Month", item.type),
                    y: .value("Revenue", item.value)
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
            .frame(height: 137)
            .padding()
        } else {
            // Fallback for earlier iOS versions
            Text("Chart not available")
        }
    }
}

#Preview {
    HistoryGraphView()
}
