//
//  page-mad.swift
//  Rabeh1
//
//  Created by Felwah on 25/03/1445 AH.
//

import SwiftUI

struct page_mad: View {
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
                            .progressViewStyle(RoundedRectProgressViewStyle())
                        
                    }.position(x: 200, y: 100)

                    Image("rabeh-mad").position(x: 100, y: 500)

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
            }

            // Function to start the progress
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

struct page_mad_Previews: PreviewProvider {
    static var previews: some View {
        page_mad()
    }
}

//function for the ProgressView
struct RoundedRectProgressViewStyle: ProgressViewStyle {
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
