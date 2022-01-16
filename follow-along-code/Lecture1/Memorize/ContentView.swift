//
//  ContentView.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/15.
//

import SwiftUI // working on UI

/* functional programming -> behaves */
// struct: collection of variables
struct ContentView: View {
    var body: some View { // some: https://stackoverflow.com/a/56433885
        
        // return this one thing -> bag of Lego
        ZStack {
            // listing the view in here
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
//                .foregroundColor(.orange) the default is inheriting from its container
            Text("Hello, world!")
                .foregroundColor(Color.orange)

        }
        .padding(.horizontal)
        .foregroundColor(.red)
        
//        return RoundedRectangle(cornerRadius: 20)
//            .stroke(lineWidth: 3)
//            .padding(.horizontal)
//            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        
//        return Text("Hello, world!").foregroundColor(Color.orange).padding()
            
    }
    
}

struct ContentView_Previews: PreviewProvider { // glues preview to ContentView
    static var previews: some View {
        ContentView()
    }
}
