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
  .init(name: "Green", count: 250),
  .init(name: "James", count: 100),
  .init(name: "Tony", count: 70)
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
