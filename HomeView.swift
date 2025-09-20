import SwiftUI
import AVFoundation
import AudioToolbox
import CoreLocation

struct HomeView: View {
    @StateObject var viewModel = SacredPlaceViewModel()
    @EnvironmentObject var language: AppLanguage
    @EnvironmentObject var flowManager: MuTeLuFlowManager
    @EnvironmentObject var memberStore: MemberStore
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var checkInStore: CheckInStore
    
    @AppStorage("loggedInEmail") var loggedInEmail: String = ""
    
    @State private var selectedTab = 0
    @State private var showBanner = false
    @State private var nearbyPlaces: [SacredPlace] = []
    
    let sacredPlaces = loadSacredPlaces()
    
    func checkProximityToSacredPlaces() {
        guard let userLocation = locationManager.userLocation else { return }
        nearbyPlaces = sacredPlaces.filter { place in
            let placeLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
            return userLocation.distance(from: placeLocation) < 200
        }
       // if !nearbyPlaces.isEmpty {
          //  print("✅ ใกล้: \(nearbyPlaces.map { $0.nameTH })")
        //}
    }
    
    var currentMember: Member? {
        memberStore.members.first { $0.email == loggedInEmail }
    }
    
    var body: some View {
        ZStack {
            if case .home = flowManager.currentScreen {
                TabView(selection: $selectedTab) {
                    MainMenuView(
                        showBanner: $showBanner,
                        currentMember: currentMember,
                        flowManager: flowManager,
                        nearbyPlaces: nearbyPlaces,
                        checkProximityToSacredPlaces: checkProximityToSacredPlaces,
                        locationManager: locationManager
                    )
                    .environmentObject(language)
                    .tabItem {
                        Label(language.localized("หน้าหลัก", "Home"), systemImage: "house")
                    }.tag(0)
                    
                    NotificationView()
                        .tabItem {
                            Label(language.localized("การแจ้งเตือน", "Notifications"), systemImage: "bell")
                        }.tag(1)
                    
                    HistoryView()
                        .tabItem {
                            Label(language.localized("ประวัติ", "History"), systemImage: "clock")
                        }.tag(2)
                    
                    NavigationStack {
                        ProfileView()
                    }
                    .tabItem {
                        Label(language.localized("ข้อมูลของฉัน", "Profile"), systemImage: "person.circle")
                    }.tag(3)
                }
                .tint(.purple)
                .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = UIColor.systemBackground
                    UITabBar.appearance().standardAppearance = appearance
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
            } else {
                switch flowManager.currentScreen {
                case .recommendation: RecommendationView(viewModel: viewModel)
                case .phoneFortune: PhoneFortuneView()
                case .shirtColor: ShirtColorView()
                case .carPlate: CarPlateView()
                case .houseNumber: HouseNumberView()
                case .tarot: TarotView()
                case .seamSi: SeamSiView()
                case .mantra: MantraView()
                case .sacredDetail: EmptyView()
                case .knowledge: KnowledgeMenuView()
                case .adminLogin: AdminLoginView()
                case .admin: AdminView()
                default: EmptyView()
                }
            }
        }
    }
}

struct NotificationView: View {
    var body: some View {
        Text("Notification Screen")
    }
}
