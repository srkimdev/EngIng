//
//  WeekChartView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/15/24.
//

import SwiftUI
import Charts

struct WeekChartView: View {
    
    var weekList: [DayTable]?
    
    var body: some View {
        
        Chart {
            ForEach(weekList ?? []) { posting in
                LineMark(
                    x: .value("Name", posting.day),
                    y: .value("Posting", posting.solveCount)
                )
                .foregroundStyle(.red)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: Array(stride(from: 0, to: 45, by: 5))) { value in
                AxisValueLabel()
                AxisTick()
                AxisGridLine()
            }
        }
        .chartYScale(domain: 0...45)
        
    }
}

#Preview {
    WeekChartView()
}
