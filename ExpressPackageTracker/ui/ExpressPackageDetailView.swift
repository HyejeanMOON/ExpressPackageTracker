//
//  ExpressPackageDetailView.swift
//  ExpressPackageTracker
//
//  Created by MOON on 2023/05/28.
//

import SwiftUI

struct ExpressPackageDetailView: View {
    @State var expressCompany:ExpressCompany
    @State var trackerIdList: [String] = []
    @State private var currentId: String = ""
    @FocusState private var focusState: Bool
    @State var isRegexExpressIncorrect: Bool = false
    @State var isWebViewShowing: Bool = false
    
    var body: some View {
        VStack{
            List{
                Section("追跡ID"){
                    TextField("追跡IDを入力してください",text: $currentId)
                        .focused($focusState)
                    Button {
                        addPackageIdToPackageIdList(id: currentId)
                        self.currentId = ""
                    } label: {
                        Text("追加")
                    }
                }
                
                Section("追跡IDリスト"){
                    ForEach(trackerIdList, id:\.self){ trackerId in
                        Label(trackerId, systemImage: "exclamationmark.circle")
                    }
                    .onDelete { index in
                        trackerIdList.remove(atOffsets: index)
                    }
                }
            }
        }
        .navigationTitle(Text(expressCompany.rawValue))
        .toolbar {
            Button {
                // TODO
                isWebViewShowing = true
            } label: {
                Label("",systemImage: "magnifyingglass")
            }

        }
        .alert("エラー", isPresented: $isRegexExpressIncorrect) {
            Button("了解"){
                self.isRegexExpressIncorrect = false
            }
        } message: {
            Text("正しい追跡IDを入力してください！")
        }
        .sheet(isPresented: $isWebViewShowing) {
            WebView(url:URL(string:"")!)
        }
    }
    
    func addPackageIdToPackageIdList(id:String){
        switch expressCompany {
        case .PostJapan:
            let domesticPattern = "[0-9]{11}"
            let internationalPattern = "[A-Z]{2}[0-9]{9}JP"
            var domesticPatternResult:[String] = []
            var internationalPatternResult:[String] = []
            self.isRegexExpressIncorrect = !(id.pregMatche(pattern: domesticPattern, matches: &domesticPatternResult) || id.pregMatche(pattern: internationalPattern, matches: &internationalPatternResult))
        case .Yamato:
            let yamatoPattern1 = "[0-9]{11}"
            let yamatoPattern2 = "[0-9]{12}"
            var yamatoPattern1Result:[String] = []
            var yamatoPattern2Result:[String] = []
            self.isRegexExpressIncorrect = !(id.pregMatche(pattern: yamatoPattern1, matches: &yamatoPattern1Result) || id.pregMatche(pattern: yamatoPattern2, matches: &yamatoPattern2Result))
        case .Sagawa:
            let sagawaPattern = "[0-9]{12}"
            var sagawaPatternResult:[String] = []
            self.isRegexExpressIncorrect = !id.pregMatche(pattern: sagawaPattern, matches: &sagawaPatternResult)
        }
        
        if(!isRegexExpressIncorrect){
            trackerIdList.append(id)
        }
    }
}

struct ExpressPackageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExpressPackageDetailView(expressCompany: .PostJapan, trackerIdList: [""])
    }
}
