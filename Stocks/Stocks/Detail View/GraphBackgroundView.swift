//
//  SwiftUIView.swift
//  Stocks
//
//  Created by David Williams on 4/16/22.
//

import SwiftUI

struct GraphBackground: Shape {
    var width: Double
    var height: Double

    func path(in rect: CGRect) -> Path {


        Path { path in

            var i = width/8
            for _ in 1...6 {
                path.move(to: CGPoint(x: rect.minX + i, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX + i, y: rect.maxY))
                i += width/8
            }

            var j = height/5
            for _ in 1...3 {
                path.move(to: CGPoint(x: rect.minX, y: rect.minY + j))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + j))
                j += height/6
            }

        }
        .strokedPath(StrokeStyle(lineWidth: 0.5, lineCap: .round))
    }

}

struct GraphBackgroundView: View {

    var width: Double
    var height: Double

    var body: some View {


        GraphBackground(width: width, height: height)
            .foregroundColor(.gray.opacity(0.3))
            .frame(width: width * 0.88235, height: height * 0.73)
           // .frame(width: width, height: height)
    }
}

struct GraphBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        GraphBackgroundView(width: 170.0, height: 100.0)
    }
}
