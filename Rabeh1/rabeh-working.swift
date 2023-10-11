//
//  rabeh-working.swift
//  Rabeh1
//
//  Created by Felwah on 26/03/1445 AH.
//

import SwiftUI

struct rabeh_working: View {
    @State private var progress = 0.0
    @State private var isProgressActive = false
    @State private var timer: Timer?
    
    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            HStack(spacing: -18) {
                Image("fire")
                
                // Progress view
                ProgressView(value: progress,
                             label: { Text("") },
                             currentValueLabel: { Text(progress.formatted(.percent.precision(.fractionLength(0)))) })
                .progressViewStyle(RRoundedRectProgressViewStyle())
                
            }.position(x: 200, y: 100)
            ZStack{
                Image("Big").position(x: 100, y: 300)
                Image("Small").position(x: 130, y: 330)
                Image("Small").position(x: 80, y: 340)
            }
            
            Image("RabehWorking").position(x: 100, y: 500)
            
            Button(action: {
                if isProgressActive {
                    stopProgress()
                } else {
                    startProgress()
                }
            }) {
                ZStack {
                    Color(red: 0.429, green: 0.199, blue: 0.127)
                    Text(isProgressActive ? "خلصت" : "افزع").font(.system(size: 36))
                        .foregroundColor(Color.white)
                }
                .clipShape(Capsule())
            }
            .frame(width: 190.0, height: 80.0)
            .padding(.top, 500.0)
        }
        .navigationBarBackButtonHidden(true) }
    func startProgress() {
        isProgressActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.progress += 0.05
            if self.progress >= 1.0 {
                stopProgress()
            }
        }
    }

    // Function to stop the progress
    func stopProgress() {
        isProgressActive = false
        timer?.invalidate()
        timer = nil
    }
}


struct rabeh_working_Previews: PreviewProvider {
    static var previews: some View {
        rabeh_working()
    }
}
struct RRoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
               // .border(Color.black)
                .frame(width: 250, height: 28)
                .foregroundColor(.white)
                 .cornerRadius(14)
          
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 28)
                .foregroundColor(.red)
        }
        .padding()
    }
}
