import SwiftUI

@main
struct MuTeLuApp: App {
    @StateObject var language = AppLanguage()
    @StateObject var flowManager = MuTeLuFlowManager()
    @StateObject var locationManager = LocationManager()
    @StateObject var memberStore = MemberStore()
    @StateObject var checkInStore = CheckInStore()
    
    var body: some Scene {
        WindowGroup {
            RootWrapperView()
                .environmentObject(language)
                .environmentObject(flowManager)
                .environmentObject(locationManager)
                .environmentObject(memberStore)
                .environmentObject(checkInStore)
        }
    }
}
