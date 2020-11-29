//
//  SetsView.swift
//  Brickie
//
//  Created by Leo on 29/11/2020.
//  Copyright © 2020 Homework. All rights reserved.
//

import SwiftUI

struct SetsView: View {
    @EnvironmentObject private var  store : Store
    @State var filter : LegoListFilter = .all
    @AppStorage(Settings.setsListSorter) var sorter : LegoListSorter = .default

    
    var body: some View {
        NavigationView{
            ScrollView {
                SearchField(searchText: $store.searchSetsText).padding(.horizontal,8)
                SetsListView(items: store.mainSets,sorter:$sorter,filter: $filter)
            }
            .toolbar{
                ToolbarItem(placement: .navigation){
                    SettingsButton()
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    if store.isLoadingData {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        FilterSorterMenu(sorter: $sorter,
                                            filter: $filter,
                                            sorterAvailable: [.default,.year,.alphabetical],
                                            filterAvailable: store.searchSetsText.isEmpty ? [.all,.wanted] : [.all,.wanted,.owned]
                        )
                    }
                    ScannerButton(code: $store.searchSetsText)
                }
            }
            .navigationBarTitle("sets.title")
        }
        .modifier(DismissingKeyboardOnSwipe())
    }

}



    


