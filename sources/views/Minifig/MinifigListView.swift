//
//  MinifigListView.swift
//  BrickSet
//
//  Created by Work on 02/05/2020.
//  Copyright © 2020 LEOLELEGO. All rights reserved.
//

import SwiftUI

struct MinifigListView: View {
    var body: some View {
        NavigationView{

         List {
             Text("My Minim")
             Text("My Sets")
             Text("My Sets")
             Text("My Sets")
            }.navigationBarTitle("minifig.title")
        }


     }
}

struct MinifigListView_Previews: PreviewProvider {
    static var previews: some View {
        MinifigListView()
    }
}