//
//  AboutView.swift
//  Bullseye
//
//  Created by Ashwani Kumar on 2020-11-22.
//

import SwiftUI

struct AboutView: View {
    
    struct HeadingStyling: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(.black)
                .padding(.vertical, 20)
        }
    }
    
    struct TextStyling: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(.black)
                .padding(.horizontal, 60)
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
        VStack {
            Text("🎯 Bullseye 🎯").padding(.top, 20).modifier(HeadingStyling())
            Text("This is Bullseye, the game where you can win point and earn fame by dragging a slider.").modifier(TextStyling())
            Text("Your goal is to place the slider as close as possible to the target value. The closer you are more points you earn.").modifier(TextStyling())
            Text("Enjoy!").modifier(TextStyling())
        }
        .background(Color(red:255.0/255.0, green:214.0/255.0, blue:179.0/255.0))
        .navigationTitle("About Bullseye")
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
