//
//  ContentView.swift
//  Practice1-Delete
//
//  Created by Oritsegbe T. Nanna on 10/27/19.
//  Copyright © 2019 Oritsegbe T.  Nanna. All rights reserved.
//

import SwiftUI

struct Prominent_Titles: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func ProminentCustomTitles() -> some View {
        self.modifier(Prominent_Titles())
    }
}

struct ContentView: View {
    
    var body: some View {
    Text("Hello world")
        .ProminentCustomTitles()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
