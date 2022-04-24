//
//  ContentView.swift
//  Stocks
//
//  Created by David Williams on 3/31/22.




import SwiftUI

var currentDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d"
    return formatter.string(from: Date())
}
var loaded = false
var fill = false


struct ContentView: View {
    @State var stocks: [Stock] = [

    ]
    @State var searchInput = ""
    @State var showNoContentAlert = false
    @State var showConnectionAlert = false
    @State var showSheet = false
    @State var presentedStock: Stock? = nil
    var body: some View {
            
        NavigationView {
            
                VStack{
                    ZStack {
//                        Color.black
//                            .ignoresSafeArea()
                        VStack {

                            Spacer()

                            List(stocks, id: \.id) {stock in
                                Button(action: {
                                    presentedStock = stock
                                    showSheet = true
                                }, label: {
                                    itemView(stock: stock)
                                })
                                .sheet(item: $presentedStock) { item in
                                        DetailView(stock: item)

                                    }
                                    .contentShape(Rectangle())
 

                            }
                            .listStyle(.inset)


                            }

                        }
                    }
                    .navigationTitle("Stocks")
                    

            }
            .searchable(text: $searchInput)
            .onAppear() {
                Task {
                    do {
                        for i in ["NVDA", "GOOG", "AAPL"] {
                            let loadedStock = try await getInfoAsync(ticker: "", local: true, localFile: i)
                            stocks.append(loadedStock!)
                        }

                    } catch {

                    }
                }
            }
            .onSubmit(of: .search) {
                Task {
                    do {
                        let searchResults = try await search(keywords: searchInput.trimmingCharacters(in: .whitespacesAndNewlines))

                        if searchResults != nil {
                            for i in searchResults! {
                                if i != nil {
                                    stocks.append(i!)
                                }
                            }

                        } else {
                            showNoContentAlert = true
                        }



                    } catch {

                        print(error.localizedDescription)
                        showConnectionAlert = true
                    }
                }

        }
            .alert(isPresented: $showConnectionAlert) {
                Alert(title: Text("Connection Error"), message: Text("We had trouble processing your request. Please try again."))
                      }
            .alert(isPresented: $showNoContentAlert) {
                Alert(title: Text("No Search Results"), message: Text("The API returns no results for this search. Please try another search term."))
                      }
            }
    
}




func itemView(stock: Stock) -> some View {

    @State var viewMode = 0

    return HStack {
        
        
        VStack(alignment: .leading,spacing: 5){
            Text(stock.fundamentalInfo.ticker)
                .font(.system(size: 18, weight: .heavy))
            Text(stock.fundamentalInfo.name)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.gray)
        }
        
        Spacer()
        
        GraphView(prices: stock.dailyInfo.prices, color: Color(stock.dailyInfo.color), width: 60, height: 35)
        .padding(.trailing)
            
            
        VStack(alignment: .trailing, spacing: 1) {
            Text(numberFormatter.string(from: NSNumber(value: stock.dailyInfo.price))!)
                .font(.system(size: 16, weight: .semibold))
                .monospacedDigit()
            
            ZStack(alignment: .trailing) {
                Color(stock.dailyInfo.color)
                    .frame(width: 70, height: 25)
                
                Text((stock.dailyInfo.change >= 0 ? "+":"") + numberFormatter.string(from: NSNumber(value: stock.dailyInfo.change))!)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium))
                    .padding(.horizontal, 6)
                
            }
            .cornerRadius(5)
        }
    }
    .padding(.vertical, 10)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
