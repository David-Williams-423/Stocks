//
//  GraphView.swift
//  Stocks
//
//  Created by David Williams on 4/8/22.
//

import SwiftUI

struct Graph: Shape {
    var points: [Double]
    var close: Bool
    func path(in rect: CGRect) -> Path {
        Path { path in
            let range = (points.max()! - points.min()!)
            
            
            path.move(to: CGPoint(x: rect.minX,
                                  y: (rect.maxY - (((points[0] - points.min()!) - range)/range) * Double(rect.height)) - Double(rect.height)))
            
            var j = 0.0
            var nextPoint = CGPoint(x:0,y:0)
            for i in points {
                
                let yIncrease = (((i - Double(points.min()!)) - range) / range) * (rect.height)
                nextPoint = CGPoint(x: Double(rect.minX + j), y: (Double(rect.minY + (rect.height - yIncrease)) - rect.height))
                
                path.addLine(to: nextPoint)
                j += Double(rect.width) / Double(points.count)
            
            }
            
            if close {
                path.addLine(to: CGPoint(x: nextPoint.x, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.closeSubpath()
            }
        }
    }
}



struct GraphView: View {
    @State var prices: [Double]
    @State var color: Color
    @State var animate: Bool = true
    var priceCount: Int = 25
    var width: Double
    var height: Double
    var annotated: Bool = false


    var body: some View {
        ZStack {

//            if annotated {
//                Color("darkGray")
//                    .frame(width: width + (width * 0.2),height: height + (height * 0.6))
//                    .cornerRadius(20)
//
//            }
            VStack(alignment: .leading) {
                HStack {
                    // Actual Graph
                    VStack {
                        ZStack {

                            if annotated {

                                GraphBackgroundView(width: width * 1.1, height: height * 1.4)
                                    //.offset(x: -10, y: -40)

                            }


                            VStack(alignment: .leading, spacing: 0){
                                LinearGradient(colors: [color.opacity(0.4),color.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                                        .mask({
                                            Graph(points: prices, close: true)
                                                .foregroundColor(color)
                                                .frame(width: width, height: height)

                                            })
                                        .frame(width: width, height: height)
                                    LinearGradient(colors: [color.opacity(0.1), color.opacity(0.00)], startPoint: .top, endPoint: .bottom)
                                    .frame(width: (width/Double(prices.count)) * (Double(prices.count) - 1), height: height * 0.3)
                                }
        //                    .opacity(animate ? 1:0)
        //                    .animation(.easeIn, value: animate)

                                VStack(spacing: 0) {
                                    Graph(points:  prices, close: false)
                                        .trim(from: 0, to: animate ? 1:0)
                                        .stroke( style: StrokeStyle(lineWidth: 1.7, lineCap: .butt, lineJoin: .bevel))
                                        .foregroundColor(color)
                                        .frame(width: width, height: height)
        //                               .animation(.easeOut(duration: 1))
                                    Rectangle()
                                        .frame(width: width, height: height * 0.3)
                                        .foregroundColor(.clear)
                                }
                            }


                    }


                    if annotated {
                        VStack(alignment: .leading) {
                            Text(formatNumber(prices.max()!))
                                .padding(.vertical, 8)
                            Text(formatNumber((prices.max()! - prices.min()!) * 0.66 + prices.min()!))
                                .padding(.vertical, 8)
                            Text(formatNumber((prices.max()! - prices.min()!) * 0.33 + prices.min()!))
                                .padding(.vertical, 8)
                            Text(formatNumber(prices.min()!))
                                .padding(.vertical, 8)
                        }
                        .foregroundColor(.white)
                        .offset(y: -20)
                    }

                }
                if annotated {
                    HStack(spacing: 35) {
                        Text("10")
                        Text("11")
                        Text("12")
                        Text("1")
                        Text("2")
                        Text("3")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .offset(y: -20)


                }
            }


        }
        .padding(.top, annotated ? 20:0)
        //.padding(.trailing, annotated ? 20:0)
        //.background(annotated ? Color("darkGray"):.clear)
        //.cornerRadius(annotated ? 10:0)
        
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            GraphView(prices: generateRandomGraph(startingValue: 100.0), color: .green, animate: true, width: 260.0, height: 150, annotated: true)


        }

    }
}
