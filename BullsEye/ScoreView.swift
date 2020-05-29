//
//  MainView.swift
//  BullsEye
//
//  Created by Tian Tong on 2020/5/29.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct Score: Identifiable {
    let id = UUID()
    let value: Int
}

struct ScoreView: View {
    
    @FetchRequest(
        entity: Entity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.value, ascending: false)]
    )
    var scores: FetchedResults<Entity>
    
    var body: some View {
        List(scores) {
            Text("\($0.value)")
        }
    }
    
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScoreView()
                .navigationBarTitle("Score", displayMode: .inline)
        }
    }
}
