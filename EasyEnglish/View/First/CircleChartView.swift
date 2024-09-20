//
//  CircleChartView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/15/24.
//

import SwiftUI
import Charts

private struct Pie: View {

    @State var slices: [(Double, Color)]

    var body: some View {
        Canvas { context, size in
            let total = slices.reduce(0) { $0 + $1.0 }
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            var startAngle = Angle.zero
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct Expense: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

struct CircleChartView: View {
    
    var body: some View {
        
        GeometryReader { geometry in
            Pie(slices: [
                (2, .red),
                (3, .orange)
            ])
            .overlay {
                Circle()
                    .fill(.white)
                    .frame(
                        width: geometry.size.width * 0.75,
                        height: geometry.size.height * 0.75
                    )
                VStack {
                    Text("14")
                    Text("Days")
                }
                
            }
        }
        
    }
    
}

//#Preview {
//    CircleChartView()
//}
