//
//  ContentView.swift
//  Bullseye
//
//  Created by Ashwani Kumar on 2020-11-21.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var scoreValue = 0
    @State var roundValue = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .modifier(ShadowStyle())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .modifier(ShadowStyle())
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: .black, radius: 5, x: 2, y:2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
            VStack {
                Spacer()
                HStack {
                    Text("Put the bulls eye as close as you can to:")
                        .modifier(LabelStyle())
                    Text("\(targetValue)")
                        .modifier(ValueStyle())
                }
                Spacer()
                HStack {
                    Text("1")
                        .modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100).accentColor(.green)
                    Text("100")
                        .modifier(LabelStyle())
                }
                
                Button(action: {
                    alertIsVisible = true
                }) {
                    Text("Hit me!")
                }
                .modifier(ButtonLargeTextStyle())
                .padding()
                .alert(isPresented: $alertIsVisible) { () -> Alert in
                    return Alert (title: Text(alertTitle()),
                                  message: Text(
                                    "You have selected \(sliderValueRounded())." +
                                        "\nYour score is \(calculateScore())"),
                                  dismissButton: .default(Text("Dismiss")){
                                    self.scoreValue = self.scoreValue + calculateScore()
                                    targetValue = Int.random(in: 1...100)
                                    roundValue += 1
                                  })
                }
                .background(Image("Button")).modifier(ShadowStyle())
                Spacer()
                HStack {
                    Button(action: {startOver()}) {
                        HStack{
                            Image("StartOverIcon")
                            Text("Start Over").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")).modifier(ShadowStyle())
                    Spacer()
                    Text("Score")
                        .modifier(LabelStyle())
                    Text("\(scoreValue)")
                        .modifier(ValueStyle())
                    Spacer()
                    Text("Round")
                        .modifier(LabelStyle())
                    Text("\(roundValue)")
                        .modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        
                            HStack{
                                Image("InfoIcon")
                                Text("Info").modifier(ButtonSmallTextStyle())
                            }
                        
                        .background(Image("Button")).modifier(ShadowStyle())
                    }
                }
                .padding(.bottom, 20)
            }
            .background(Image("Background"), alignment: .center)
            .accentColor(midnightBlue)
            .navigationTitle("Bullseye")
    }
    
    func calculateScore() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    func sliderValueRounded() -> Int{
        Int(sliderValue.rounded())
    }
    
    func startOver() -> Void {
        scoreValue = 0;
        roundValue = 1;
        sliderValue = 50.0
        targetValue = Int.random(in: 1...100)
    }
    
    func amountOff() -> Int {
        abs(targetValue - sliderValueRounded())
    }
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad"
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
 
