//
//  SearchPackageDialog.swift
//  ExpressPackageTracker
//
//  Created by MOON on 2023/05/28.
//

import SwiftUI

struct SearchPackageDialog: View {
    @Binding var expressCompany: ExpressCompany
    @Binding var show: Bool
    @State private var currentId: String = ""
    @FocusState private var focusState: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if show {
                if(colorScheme == .light) {
                    Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                } else {
                    Color.white.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                }
                
                VStack(alignment: .center, spacing: 0) {
                    Text(expressCompany.rawValue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment:.center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .padding(.top, 20)
                       
                    HStack {
                        Label("",systemImage: "exclamationmark.circle")
                        TextField("追跡IDを入力してください",text: $currentId)
                            .frame(maxWidth: .infinity)
                            .focused($focusState)
                                
                    }
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    .padding(.top, 20)
                    
                    HStack {
                        Button {
                            hideDialog()
                        } label: {
                            Label("Cancel", systemImage: "xmark")
                        }
                        
                        Spacer()
                        
                        Button {
                            hideDialog()
                            // TODO
                        } label: {
                            Label("Search",systemImage: "magnifyingglass")
                        }
                    }
                    .padding(.top, 20)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.bottom, 20)
                    
                }
                .frame(maxWidth: 300)
                .background(colorScheme == .dark ? Color.black:Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                focusState = true
            }
        }
    }
    
    func hideDialog (){
        show = false
    }
}

//struct SearchPackageDialog_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchPackageDialog(
//            expressCompany: ExpressCompany.Yamato,
//            show: true
//        )
//    }
//}
