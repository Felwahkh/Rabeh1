import SwiftUI

struct rabeh_working: View {
    @State private var progress = 0.0
    @State private var isProgressActive = false
    @State private var timer: Timer?
    @State private var img = "fire"
    @State private var img2 = "fire-green"
    @State private var buttonTitle = "افزع"
    @State private var isDone = false
    @State private var imgRabehMad = "rabeh-mad"

    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            HStack(spacing: -18) {
                let pic = progress <= 0.5 ? "fire" : "fire-green"
                Image(pic)
                
                // Progress view
                ProgressView(value: progress,
                             label: { Text("") },
                             currentValueLabel: { Text(progress.formatted(.percent.precision(.fractionLength(0)))) })
                    .progressViewStyle(ColoredRoundedRectProgressViewStyle(progress: progress))
                
            }.position(x: 200, y: 100)
            ZStack {
                Image("Big").position(x: 100, y: 300)
                Image("Small").position(x: 130, y: 330)
                Image("Small").position(x: 80, y: 340)
            }
            
            Image(isProgressActive ? "RabehWorking" : (isDone ? "rabeh-done" : "RabehWorking"))
                .position(x: 150, y: 500)
            
            Button(action: {
                if isProgressActive {
                    isDone = true
                    buttonTitle = "افزع"
                } else {
                    isDone = false
                    buttonTitle = "خلصت"
                }
                isProgressActive.toggle()
                toggleProgress()
            }) {
                ZStack {
                    Color(red: 0.429, green: 0.199, blue: 0.127)
                    Text(buttonTitle).font(.system(size: 36))
                        .foregroundColor(Color.white)
                }
                .clipShape(Capsule())
            }
            .frame(width: 190.0, height: 80.0)
            .padding(.top, 500.0)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func toggleProgress() {
        if isProgressActive {
            startProgress()
        } else {
            stopProgress()
        }
    }
    
    func startProgress() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.progress += 0.05
            if self.progress >= 1.0 {
                stopProgress()
            }
        }
    }

    // Function to stop the progress
    func stopProgress() {
        timer?.invalidate()
        timer = nil
    }
}

struct rabeh_working_Previews: PreviewProvider {
    static var previews: some View {
        rabeh_working()
    }
}

struct ColoredRoundedRectProgressViewStyle: ProgressViewStyle {
    var progress: Double
    
    func makeBody(configuration: Configuration) -> some View {
        let color = progress <= 0.5 ? Color.red : Color.green
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: 250, height: 28)
                .foregroundColor(.white)
                .cornerRadius(14)
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 28)
                .foregroundColor(color)
        }
        .padding()
    }
}
