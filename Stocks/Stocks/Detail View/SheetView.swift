//
//  SheetView.swift
//  Stocks
//
//  Created by David Williams on 4/23/22.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    var stock: Stock
    var body: some View {
        DetailView(stock: stock)
    }

}

//struct SheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SheetView()
//    }
//}
