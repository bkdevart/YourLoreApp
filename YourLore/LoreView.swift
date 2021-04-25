//
//  LoreView.swift
//  YourLore
//
//  Created by Brandon Knox on 4/24/21.
//

import SwiftUI

struct LoreView: View {
    let lore: Lore
    
    var body: some View {
        Text(self.lore.title)
            .font(.headline)
        Text(self.lore.story)
            .font(.body)
    }
    
    init(lore: Lore) {
        self.lore = lore
    }
}

struct LoreView_Previews: PreviewProvider {
    static let lore = Lore(id: 0, title: "default story", story: "A very short story.")
    
    static var previews: some View {
        LoreView(lore: lore)
    }
}
