import SwiftUI
import FirebaseAnalytics
import FirebaseCrashlytics

struct ContentView: View {
    @State private var counter = 0
    
    // Função para log de evento personalizado
    private func logCounterIncrement() {
        Analytics.logEvent("counter_increment", parameters: [
            "counter_value": counter as NSNumber,
            "timestamp": Date().timeIntervalSince1970 as NSNumber
        ])
    }
    
    // Função para log de exceção controlada
    private func logControledException() {
        do {
            throw NSError(
                domain: "ControlledTestException",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Controlled test exception"
                ]
            )
        } catch {
            // Log no Crashlytics
            Crashlytics.crashlytics().record(error: error)
            
            // Log no Analytics
            Analytics.logEvent("controlled_exception", parameters: [
                "error_description": error.localizedDescription,
                "error_code": error._code as NSNumber,
                "timestamp": Date().timeIntervalSince1970 as NSNumber
            ])
            
            print("Caught exception: \(error.localizedDescription)")
        }
    }
    
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
                        logCounterIncrement()
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
                        logControledException()
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
        .onAppear {
            // Log quando o app é aberto
            Analytics.logEvent(AnalyticsEventAppOpen, parameters: [
                "platform": "iOS",
                "version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown",
                "timestamp": Date().timeIntervalSince1970 as NSNumber
            ])
        }
    }
}
