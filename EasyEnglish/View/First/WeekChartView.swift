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
        
//        let _ = print(repository.detectRealmURL())
        
        Chart {
            ForEach(weekList ?? []) { posting in
                LineMark(
                    x: .value("Name", posting.day),
                    y: .value("Posting", posting.solveCount)
                )
                .foregroundStyle(.red)
            }
        }
        
    }
}

#Preview {
    WeekChartView()
}
