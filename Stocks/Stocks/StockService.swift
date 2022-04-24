import Foundation
import UIKit
import SwiftUI

extension UIColor {

    func modified(withAdditionalHue hue: CGFloat=0, additionalSaturation: CGFloat=0, additionalBrightness: CGFloat=0) -> UIColor {

        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0

        if self.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha){
            return UIColor(hue: currentHue + hue,
                           saturation: currentSaturation + additionalSaturation,
                           brightness: currentBrigthness + additionalBrightness,
                           alpha: currentAlpha)
        } else {
            return self
        }
    }
}



func generateRandomGraph(startingValue: Double) -> [Double] {
    var result: [Double] = [startingValue]
    for _ in 1...25 {
        result.append(Double.random(in: (result.last! - (startingValue * 0.01))...(result.last! + (startingValue * 0.01))))
    }
    return result
}


let apiKeys = ["LWIMA6WNDVGPJZWM", "W850JWC7O9AI973I", "Y59CI5VBR8XNQZK7", "5DZ58XI5M80P8T7L", "A1PNYS698P0E9TAT", "KN7BTYJ7UZOVRE3V", "0ZP6J78FZVKICTRO", "10HQUQ9NOU8K64OA", "7XS0R049YMOYV3SI", "34IMYL339VGPERE1", "BX2HYNWF8YUM22Y8", "K829SMMO0KBQNU25", "YIHXUCWEYTDI6692", "BZA7Q8PDL5G23411", "EHFCSMC9EAIX9J2O", "T886NUKM75NXETB0", "6RAERETK5J0R4PT5", "9GZHMM9OBTFQOVKK"]
var apiCounter = 0
var totalApiCalls = 0
var retryCounter = 0

var currentKey = apiKeys[apiCounter]

let baseURL = "https://www.alphavantage.co/query?function="

struct TimeSeriesResult: Codable {

    var metaData: MetaData?
    var timeSeries15Min: [String:Quote]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries15Min = "Time Series (15min)"
    }
}

struct Quote: Codable {
    var open: String
    var high: String
    var low: String
    var close: String
    var volume: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}

struct MetaData: Codable {
    var info: String
    var symbol: String
    var lastRefreshed: String
    var interval: String
    var outputSize: String
    var timeZone: String

    enum CodingKeys: String, CodingKey {
        case info = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
    }
}

struct Overview: Codable {
    var Symbol: String?
    var AssetType: String?
    var Name: String?
    var Description: String?
    var CIK: String?
    var Exchange: String?
    var Currency: String?
    var Country: String?
    var Sector: String?
    var Industry: String?
    var Address: String?
    var FiscalYearEnd: String?
    var LatestQuarter: String?
    var MarketCapitalization: String?
    var EBITDA: String?
    var PERatio: String?
    var PEGRatio: String?
    var BookValue: String?
    var DividendPerShare:  String?
    var DividendYield: String?
    var EPS: String?
    var RevenuePerShareTTM: String?
    var ProfitMargin: String?
    var OperatingMarginTTM: String?
    var ReturnOnAssetsTTM: String?
    var ReturnOnEquityTTM: String?
    var RevenueTTM: String?
    var GrossProfitTTM: String?
    var DilutedEPSTTM: String?
    var QuarterlyEarningsGrowthYOY: String?
    var QuarterlyRevenueGrowthYOY: String?
    var AnalystTargetPrice: String?
    var TrailingPE: String?
    var ForwardPE: String?
    var PriceToSalesRatioTTM: String?
    var PriceToBookRatio: String?
    var EVToRevenue: String?
    var EVToEBITDA: String?
    var Beta: String?
    var yearHigh: String?
    var yearLow: String?
    var FiftyDMovingAverage: String?
    var TwoHundredDMovingAverage: String?
    var SharesOutstanding: String?
    var DividendDate: String?
    var ExDividendDate: String?

    enum CodingKeys: String, CodingKey {
        case yearHigh = "52WeekHigh"
        case yearLow = "52WeekLow"
        case FiftyDMovingAverage = "50DayMovingAverage"
        case TwoHundredDMovingAverage = "200DayMovingAverage"
        case Symbol, AssetType, Name, Description, CIK, Exchange, Currency, Country, Sector, Industry, Address, FiscalYearEnd, LatestQuarter, MarketCapitalization, EBITDA, PERatio, PEGRatio, BookValue, DividendPerShare, DividendYield, EPS, RevenuePerShareTTM, ProfitMargin, OperatingMarginTTM, ReturnOnAssetsTTM, ReturnOnEquityTTM, RevenueTTM, GrossProfitTTM, DilutedEPSTTM, QuarterlyEarningsGrowthYOY, QuarterlyRevenueGrowthYOY, AnalystTargetPrice, TrailingPE, ForwardPE, PriceToSalesRatioTTM, PriceToBookRatio, EVToRevenue, EVToEBITDA, Beta, SharesOutstanding, DividendDate, ExDividendDate
    }
}

struct Search: Codable {
    var bestMatches: [match]?
}

struct match: Codable {

    var symbol: String
    var name: String
    var type: String
    var region: String
    var marketOpen: String
    var marketClose: String
    var timezone: String
    var currency: String
    var matchScore: String

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timezone = "7. timezone"
        case currency = "8. currency"
        case matchScore = "9. matchScore"
}


}
struct Stock: Identifiable {

    // Fundamental
    let id = UUID()

    struct Fundamental {

        var ticker: String
        var name: String
        var EPS: Double?
        var PERatio: Double?
        var description: String?
        var marketCap: Int?
        var yearHigh: Double?
        var yearLow: Double?
        var shares: Int?
        var yield: Double?
        var beta: Double?

    }

    // Daily
    struct Daily {
        var quotes: [Quote]
        var afterHoursQuotes: [Quote]
        var preMarketQuotes: [Quote]

        var change: Double {
            prices.last! - prices.first!
        }

        var prices: [Double] {
            var result: [Double] = []
            for quote in quotes {
                result.append(Double(quote.close)!)
            }
            return result
        }
        var afterHoursPrices: [Double] {
            var result: [Double] = []
            for quote in afterHoursQuotes {
                result.append(Double(quote.close)!)
            }
            return result
        }
        var preMarketPrices: [Double] {
            var result: [Double] = []
            for quote in preMarketQuotes {
                result.append(Double(quote.close)!)
            }
            return result
        }

        var totalVolume: Int {
            var result: Int = 0
            for quote in quotes {
                result += Int(quote.volume)!
            }
            return result
        }

        var percentChange: Double {
            (change/prices.first!) * 100
        }

        var price: Double {
            prices.last!
        }
        var color: UIColor {
            change < 0 ? UIColor.red.modified(additionalSaturation: -0.22) : UIColor.green.modified(additionalSaturation: -0.39, additionalBrightness: -0.15)
        }
    }

    var fundamentalInfo: Fundamental
    var dailyInfo: Daily

}

func search(keywords: String) async throws -> [Stock?]? {
    let url = URL(string: "\(baseURL)SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(currentKey)") ?? nil
    //let url = URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=demo")!
    if url == nil {
        return nil
    }
    print("Search using: \(url)")

    let (data, _) = try await URLSession.shared.data(from: url!)

    let decoder = JSONDecoder()
    let result = try decoder.decode(Search.self, from: data)

    apiCounter += 1
    totalApiCalls += 1
    if apiCounter == apiKeys.count {
        apiCounter = 0
    }
    currentKey = apiKeys[apiCounter]

    guard result.bestMatches?.count != 0 && result.bestMatches != nil else {

        print("No Data for search. Try: \(apiCounter). Key: \(currentKey)")
        retryCounter += 1
        if retryCounter == apiKeys.count {
            retryCounter = 0
            return nil
        }
        return try await search(keywords: keywords)

    }

    var symbolList: [String] = []

    if result.bestMatches?.count != 0 {
        symbolList.append(result.bestMatches![0].symbol)
    } else {
        return nil
    }

    print(symbolList)
    
    var stockList: [Stock?] = []
    for i in symbolList {
        stockList.append(try await getInfoAsync(ticker: i))
    }
    print("Total API Calls for '\(keywords)' search: \(totalApiCalls)")
    totalApiCalls = 0
    //print(stockList)
    return stockList

}

func overviewAsync(ticker: String, local: Bool=false, localFile: String="") async throws -> Stock.Fundamental? {
    guard var url = URL(string: "\(baseURL)OVERVIEW&symbol=\(ticker)&apikey=\(currentKey)") else { return nil }
    
    //let url = URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=demo")!
    print("Overview using: \(url)")
    if local {
        url = Bundle.main.url(forResource: localFile, withExtension: "json")!
    }

    let (data, _) = try await URLSession.shared.data(from: url)

    //print(String(data: data, encoding: .utf8)!)
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(Overview.self, from: data)

    totalApiCalls += 1
    apiCounter += 1
    if apiCounter == apiKeys.count {
        apiCounter = 0
    }
    currentKey = apiKeys[apiCounter]

    if result.Symbol != nil {
        return Stock.Fundamental(
                                    ticker: result.Symbol!,
                                    name: result.Name!,
                                    EPS: (result.EPS != nil) ? Double(result.EPS!):nil,
                                    PERatio: (result.PERatio != nil) ? Double(result.PERatio!):nil,
                                    description: (result.Description != nil) ? result.Description:nil,
                                    marketCap: (result.MarketCapitalization != nil) ? Int(result.MarketCapitalization!):nil,
                                    yearHigh: (result.yearHigh != nil) ? Double(result.yearHigh!):nil,
                                    yearLow: (result.yearLow != nil) ? Double(result.yearLow!):nil,
                                    shares: (result.SharesOutstanding != nil) ? Int(result.SharesOutstanding!):nil,
                                    yield: (result.DividendYield != nil) ? Double(result.DividendYield!):nil,
                                    beta: (result.Beta != nil) ? Double(result.Beta!):nil
                                )
    } else {

        print("No Data for overview. Try: \(totalApiCalls). Key: \(currentKey)")
        retryCounter += 1
        if retryCounter == apiKeys.count {
            retryCounter = 0
            return nil
        }
        return try await overviewAsync(ticker: ticker)
    }
}

func timeSeriesAsync(ticker: String, interval: String, local: Bool=false, localFile: String="") async throws -> Stock.Daily? {

    var url = URL(string: "\(baseURL)TIME_SERIES_INTRADAY&symbol=\(ticker)&interval=\(interval)&apikey=\(currentKey)") ?? nil
    //let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=demo")!
    if url == nil {
        return nil
    }
    if local {
        url = Bundle.main.url(forResource: localFile, withExtension: "json")
    }
    print("Time Series using: \(url)")


    var quotes: [Quote] = []
    var preMarketQuotes: [Quote] = []
    var afterHoursQuotes: [Quote] = []

    let (data, _) = try await URLSession.shared.data(from: url!)

    apiCounter += 1
    totalApiCalls += 1

    if apiCounter == apiKeys.count {
        apiCounter = 0
    }
    currentKey = apiKeys[apiCounter]
    let decoder = JSONDecoder()
    let result = try decoder.decode(TimeSeriesResult.self, from: data)
    print("Got here!")


    guard result.metaData != nil else {

        print("No Data for Time Series. Try: \(totalApiCalls). Key: \(currentKey)")

        return try await timeSeriesAsync(ticker: ticker, interval: "15min")

    }


    var dateList: [Date] = []

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"


    for i in result.timeSeries15Min {
        dateList.append(dateFormatter.date(from: i.key)!)
    }



    dateList.sort()

    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = "yyyy-MM-dd"

    let currentDayString = dayFormatter.string(from: dateList[dateList.count - 3])
    let currentDay = dayFormatter.date(from: currentDayString)

    for i in dateList {

        if i < currentDay! {
            dateList.remove(at: dateList.firstIndex(of: i)!)
        }
    }

    print(dateList)

    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"

    for i in dateList {

        let currentTime = timeFormatter.date(from: timeFormatter.string(from: i))!
        if  currentTime <= timeFormatter.date(from: "16:00")! && currentTime >= timeFormatter.date(from: "09:30")! {

            quotes.append(result.timeSeries15Min[dateFormatter.string(from: i)]!)

        } else if currentTime < timeFormatter.date(from: "09:30")! {
            preMarketQuotes.append(result.timeSeries15Min[dateFormatter.string(from: i)]!)
        } else {
            afterHoursQuotes.append(result.timeSeries15Min[dateFormatter.string(from: i)]!)
        }
    }
    print(quotes)
    return Stock.Daily(quotes: quotes, afterHoursQuotes: afterHoursQuotes, preMarketQuotes: preMarketQuotes)

}

func getInfoAsync(ticker: String, interval: String="15min", local: Bool=false, localFile: String="") async throws -> Stock? {
    guard let overview = try await overviewAsync(ticker: ticker, local: local, localFile: localFile + "_Fundamental") else {return nil}
    guard let timeSeries = try await timeSeriesAsync(ticker: ticker, interval: interval, local: local, localFile: localFile + "_Daily") else {return nil}

    return Stock(fundamentalInfo: overview, dailyInfo: timeSeries)
}
