import SwiftUI

struct AppView: View {
    @EnvironmentObject var flowManager: MuTeLuFlowManager
    @EnvironmentObject var language: AppLanguage
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var memberStore: MemberStore
    @StateObject var checkInStore = CheckInStore()
    
    var body: some View {
        Group {
            switch flowManager.currentScreen {
            case .login:
                LoginView()
            case .registration:
                RegistrationView()
            case .home:
                HomeView()
                    .environmentObject(flowManager)
                    .environmentObject(language)
                    .environmentObject(memberStore)
                    .environmentObject(locationManager)
                    .environmentObject(checkInStore)
            case .recommendation:
                RecommendationView(viewModel: SacredPlaceViewModel())
            case .sacredDetail(let place):
                SacredPlaceDetailView(place: place)
                    .environmentObject(language)
                    .environmentObject(flowManager)
                    .environmentObject(checkInStore)
                    .environmentObject(memberStore)
            case .phoneFortune:
                PhoneFortuneView()
            case .shirtColor:
                ShirtColorView()
            case .carPlate:
                CarPlateView()
            case .houseNumber:
                HouseNumberView()
            case .tarot:
                TarotView()
            case .mantra:
                MantraView()
            case .seamSi:
                SeamSiView()
            case .knowledge:
                KnowledgeMenuView()
            case .wishDetail:
                WishDetailView()
            case .adminLogin:
                AdminLoginView()
            case .admin:
                AdminView()
            case .gameMenu:
                GameMenuView()
            case .meritPoints:
                MeritPointsView()
            case .offeringGame:
                OfferingGameView()
                    .environmentObject(language)
                    .environmentObject(flowManager)
            @unknown default:
                Text("Coming soon...")
                
            }
        }
    }
}
