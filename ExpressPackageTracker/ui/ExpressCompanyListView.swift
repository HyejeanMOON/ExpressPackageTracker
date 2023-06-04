//
//  ContentView.swift
//  ExpressPackageTracker
//
//  Created by MOON on 2023/05/28.
//

import SwiftUI
import CoreData

struct ExpressCompanyListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SearchiHistoryItem.lastUpdate, ascending: true)],
        animation: .default
    )
    private var searchHistorys: FetchedResults<SearchiHistoryItem>
    
    @State var shouldShowDialog: Bool = false
    @State var selectedExpressCompany:ExpressCompany = ExpressCompany.PostJapan
    
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    Section(header:Text("会社")){
                        ForEach(ExpressCompany.allCases, id:\.self){ company in
                            Button {
                                selectedExpressCompany = company
                                shouldShowDialog = true
                            } label: {
                                Label(company.rawValue,systemImage: "house")
                            }
                            
                        }
                    }
                    
                    Section(header: Text("検索履歴")){
                        if(searchHistorys.isEmpty){
                            Label("検索履歴なし",systemImage: "magnifyingglass")
                        }else{
                            List{
                                ForEach(searchHistorys){ item in
                                    Label(item.trackerId ?? "",systemImage: "magnifyingglass")
                                }
                            }
                        }
                    }
                }
                .navigationTitle(Text("Package Tracker"))
                .navigationBarHidden(false)
            }
            SearchPackageDialog(expressCompany: $selectedExpressCompany, show: $shouldShowDialog)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpressCompanyListView()
    }
}
