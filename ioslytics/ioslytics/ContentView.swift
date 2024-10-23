import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    
    var body: some View {
        VStack {
            // Title Section
            Text("Firebase Analytics Test Lab")
                .font(.title)
                .padding(.top, 24)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
            
            // Firebase Logo
            Image("firebase_logo")
                .resizable()
                .scaledToFit()
                .frame(height: 48)
                .padding(.bottom, 24)
            
            // Main Container
            VStack(spacing: 16) {
                // Counter Section
                VStack {
                    Text("Counter: \(counter)")
                        .font(.headline)
                    
                    Button("Increment Counter") {
                        counter += 1
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
                
                // Exception Section
                VStack {
                    Text("Exception Test")
                        .font(.headline)
                    
                    Button("Generate Controlled Exception") {
                        do {
                            throw NSError(domain: "Controlled test exception",
                                        code: -1,
                                        userInfo: nil)
                        } catch {
                            print("Caught exception: \(error.localizedDescription)")
                            // Will add Crashlytics logging here later
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(8)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange.opacity(0.2))
                .cornerRadius(8)
                
                // Crash Section
                VStack {
                    Text("Danger Zone")
                        .font(.headline)
                    
                    Button("Force App Crash") {
                        fatalError("Intentional app crash")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemPink).opacity(0.2))
                .cornerRadius(8)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding()
            
            Spacer()
        }
    }
}
