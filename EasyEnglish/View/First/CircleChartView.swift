//
//  CircleChartView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/15/24.
//

import SwiftUI
import Charts

private struct Pie: View {

    var slices: [(Double, Color)]

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

struct CircleChartView: View {
    
    @Binding var solved: Int
    @Binding var total: Int
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let solvedDouble = Double(solved)
            let totalDouble = Double(total)
            
            Pie(slices: [
                (solvedDouble, .red),
                (totalDouble - solvedDouble, .gray.opacity(0.2))
            ])
            .overlay {
                Circle()
                    .fill(.white)
                    .frame(
                        width: geometry.size.width * 0.75,
                        height: geometry.size.height * 0.75
                    )
                VStack {
                    if totalDouble > 0 {
                        Text("\(Int(solvedDouble / totalDouble * 100))%")
                    } else {
                        Text("0%")
                    }
                }
                
            }
        }
        
    }
    
}

//#Preview {
//    CircleChartView(solved: 20)
//}
