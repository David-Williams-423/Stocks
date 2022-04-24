//
//  DetailView.swift
//  Stocks
//
//  Created by David Williams on 4/8/22.
//

import SwiftUI

func formatNumber(_ number: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal

//TODO: rework this
    let formattedNumber = numberFormatter.string(from: NSNumber(value: number))
    if number > 999.99 {
        return String(format: "%.0f", number)
    }
    return String(format: "%.2f", number)

}

var numberFormatter: NumberFormatter {
    let a = NumberFormatter()
    a.numberStyle = .decimal
    return a
}

struct DetailView: View {

    @State var animate: Bool = true
    var stock: Stock
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()

            VStack {
                HStack(alignment: .bottom) {
                    Text(stock.fundamentalInfo.ticker)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    Text(stock.fundamentalInfo.name)
                        .foregroundColor(.gray)
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                }
                .padding()
            ScrollView {


                VStack {



                    Divider()
                        .background(.white)
                    VStack {
                        HStack(alignment: .top) {

                            VStack(alignment: .leading) {
                                HStack {
                                    Text(numberFormatter.string(from: NSNumber(value: stock.dailyInfo.price))!)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                    Text(String(format: "%.2f", ((stock.dailyInfo.prices.last! - stock.dailyInfo.prices[0])/stock.dailyInfo.prices[0]) * 100) + "%")
                                            .foregroundColor(Color(stock.dailyInfo.color))
                                }
                                Text("At Close")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                            Divider()
                                .frame(height: 45)

                            VStack(alignment: .leading) {
                                HStack {
                                    Text(numberFormatter.string(from: NSNumber(value: stock.dailyInfo.afterHoursPrices.last!))!)
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                    Text(String(format: "%.2f", ((stock.dailyInfo.afterHoursPrices.last! - stock.dailyInfo.afterHoursPrices[0])/stock.dailyInfo.afterHoursPrices[0]) * 100) + "%")
                                            .foregroundColor(Color(stock.dailyInfo.color))
                                }
                                Text("After Hours")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        HStack(spacing: 32) {
                            Text("1D")
                            Text("1W")
                            Text("1M")
                            Text("3M")
                            Text("6M")
                            Text("YTD")
                            Text("ALL")
                        }
                        .font(.system(size: 15, weight: .semibold))
                        Divider()
                        HStack {
                            GraphView(prices: stock.dailyInfo.prices, color: Color(stock.dailyInfo.color), animate: animate, width: 310, height: 130, annotated: true)
                                .padding(.bottom)
                            Spacer()
                        }


                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack() {

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Open")
                                        Text("High")
                                        Text("Low")
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.gray)
                                    Spacer()

                                    VStack(alignment: .trailing) {
                                        Text(numberFormatter.string(from: NSNumber(value: stock.dailyInfo.prices.first!))!)
                                        Text(numberFormatter.string(from: NSNumber(value: stock.dailyInfo.prices.max()!))!)
                                        Text(numberFormatter.string(from: NSNumber(value: stock.dailyInfo.prices.min()!))!)
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                                }
                                .frame(width: 130)


                                Divider()
                                    .frame(height: 50)

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Vol")
                                        Text("P/E")
                                        Text("Mkt Cap")
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.gray)

                                    Spacer()

                                    VStack(alignment: .trailing) {
                                        Text((stock.dailyInfo.totalVolume != nil) ? String(format: "%.2f", stock.dailyInfo.totalVolume): "-")
                                        Text((stock.fundamentalInfo.PERatio != nil) ? String(format: "%.2f", stock.fundamentalInfo.PERatio!): "-")
                                        Text((stock.fundamentalInfo.marketCap != nil) ? String(format: "%.2f", stock.fundamentalInfo.marketCap!): "-")
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                                }
                                .frame(width: 130)


                                Divider()
                                    .frame(height: 50)

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("52W H")
                                        Text("52W L")
                                        Text("Shares")
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.gray)

                                    Spacer()

                                    VStack(alignment: .trailing) {
                                        Text((stock.fundamentalInfo.yearHigh != nil) ? String(format: "%.2f", stock.fundamentalInfo.yearHigh!): "-")
                                        Text((stock.fundamentalInfo.yearLow != nil) ? String(format: "%.2f", stock.fundamentalInfo.yearLow!): "-")
                                        Text((stock.fundamentalInfo.shares != nil) ? String(format: "%.2f", stock.fundamentalInfo.shares!): "-")
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                                }
                                .frame(width: 130)

                                Divider()
                                    .frame(height: 50)

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Yield")
                                        Text("Beta")
                                        Text("EPS")
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.gray)
                                    Spacer()

                                    VStack(alignment: .trailing) {
                                        Text((stock.fundamentalInfo.yield != nil) ? String(format: "%.2f", stock.fundamentalInfo.yield!): "-")
                                        Text((stock.fundamentalInfo.beta != nil) ? String(format: "%.2f", stock.fundamentalInfo.beta!): "-")
                                        Text((stock.fundamentalInfo.EPS != nil) ? String(format: "%.2f", stock.fundamentalInfo.EPS!): "-")


                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                                }
                                .frame(width: 130)

                            }
                        }
                    }

                    HStack {
                        Text(stock.fundamentalInfo.description ?? "This stock does not have a description.")
                        Spacer()

                    }
                    .padding(.vertical, 20)

                    Spacer()

                }
            }


            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {

        DetailView(stock: exampleStock)
            .colorScheme(.dark)
            .onAppear() {

            }

    }
}
var exampleQuotes = [Quote(open: "215.2892", high: "217.2300", low: "214.3800", close: "216.9500", volume: "2081466"), Quote(open: "217.0000", high: "217.1350", low: "214.8311", close: "215.2450", volume: "1620883"), Quote(open: "215.3000", high: "215.5000", low: "212.9000", close: "213.8140", volume: "1908083"), Quote(open: "213.7800", high: "214.9700", low: "213.3915", close: "214.6350", volume: "1351803"), Quote(open: "214.6100", high: "214.9000", low: "213.3501", close: "213.5500", volume: "1264429"), Quote(open: "213.5290", high: "213.8250", low: "212.5100", close: "212.6000", volume: "1388367"), Quote(open: "212.5800", high: "212.6800", low: "209.6100", close: "210.0800", volume: "2863225"), Quote(open: "210.0900", high: "210.8940", low: "209.1000", close: "209.7596", volume: "2288176"), Quote(open: "209.7400", high: "210.3299", low: "208.3705", close: "208.6506", volume: "1758523"), Quote(open: "208.6350", high: "209.2400", low: "208.1000", close: "208.8906", volume: "1694406"), Quote(open: "208.8950", high: "209.8250", low: "206.0100", close: "207.0000", volume: "2734944"), Quote(open: "207.0000", high: "207.2999", low: "204.6670", close: "206.2000", volume: "2955240"), Quote(open: "206.1800", high: "208.1300", low: "205.3200", close: "207.8500", volume: "2673960"), Quote(open: "207.8700", high: "208.3000", low: "204.5300", close: "205.4900", volume: "2540256"), Quote(open: "205.5200", high: "205.5800", low: "203.6100", close: "204.1000", volume: "2203011"), Quote(open: "204.0600", high: "204.0600", low: "200.5342", close: "200.5700", volume: "3017159"), Quote(open: "200.5691", high: "203.6400", low: "200.5100", close: "203.3283", volume: "2648642"), Quote(open: "203.3201", high: "204.5899", low: "202.5701", close: "202.6100", volume: "2129243"), Quote(open: "202.6000", high: "203.5454", low: "202.4300", close: "203.2999", volume: "1471421"), Quote(open: "203.2550", high: "203.3000", low: "201.1000", close: "201.2400", volume: "1670936"), Quote(open: "201.2200", high: "201.9700", low: "200.8000", close: "201.7799", volume: "2269743"), Quote(open: "201.7201", high: "202.0750", low: "200.3600", close: "201.3292", volume: "2747492"), Quote(open: "201.3001", high: "202.6600", low: "200.0000", close: "201.5500", volume: "4536801")]

var exampleStock = Stock(fundamentalInfo: Stock.Fundamental(ticker: "AAPL", name: "Apple Inc.", EPS: 6.01, PERatio: 3.45, description: "Apple is a very good company. Invest in apple!", marketCap: 2135350000000, yearHigh: 152.09, yearLow: 98.92, shares: 5435264600, yield: 0.09, beta: 1.13), dailyInfo: Stock.Daily(quotes: exampleQuotes, afterHoursQuotes: exampleQuotes, preMarketQuotes: exampleQuotes))

