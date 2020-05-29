//
//  ContentView.swift
//  BullsEye
//
//  Created by Tian Tong on 2020/5/29.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    
    // 0 244 168
    // 18 215 241
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    @State var showAlert: Bool = false
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        let score = Int((1.0 - diff) * 100.0 + 0.5)
        let entity = Entity(context: context)
        entity.value = String(score)
        saveContext()
        return score
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Saving error: \(error)")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Rectangle().foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget))
                        Text("Match this color")
                    }
                    
                    VStack {
                        Rectangle().foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess))
                        HStack {
                            Text("R: \(Int(rGuess * 255.0))")
                            Text("G: \(Int(gGuess * 255.0))")
                            Text("B: \(Int(bGuess * 255.0))")
                        }
                    }
                }
                
                Button(action: {
                    self.showAlert = true
                }) {
                    Text("Hit Me!")
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"), message: Text("\(computeScore())"))
                }.padding()
                
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $gGuess, textColor: .green)
                    ColorSlider(value: $bGuess, textColor: .blue)
                }
            }
            .navigationBarTitle("BullsEye", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: ScoreView(), label: {
                    Text("Scores")
                })
            )
        }
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}
