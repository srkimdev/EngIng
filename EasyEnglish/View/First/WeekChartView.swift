//
//  WeekChartView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/15/24.
//

import SwiftUI
import Charts

struct Posting: Identifiable {
  let name: String
  let count: Int
  
  var id: String { name }
}

let postings: [Posting] = [
  .init(name: "MON", count: 20),
  .init(name: "TUE", count: 18),
  .init(name: "WED", count: 40),
  .init(name: "THU", count: 50),
  .init(name: "FRI", count: 20),
  .init(name: "SAT", count: 10),
  .init(name: "SUN", count: 30)
]

struct WeekChartView: View {
    var body: some View {
        
        Chart {
            ForEach(postings) { posting in
                LineMark(
                    x: .value("Name", posting.name),
                    y: .value("Posting", posting.count)
                )
                .foregroundStyle(Color.red)
            }
        }
        
    }
}

#Preview {
    WeekChartView()
}
