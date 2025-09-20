import SwiftUI
import CoreLocation

struct MainMenuView: View {
    @Binding var showBanner: Bool
    @EnvironmentObject var language: AppLanguage
    var currentMember: Member?
    var flowManager: MuTeLuFlowManager
    var nearbyPlaces: [SacredPlace]
    var checkProximityToSacredPlaces: () -> Void
    var locationManager: LocationManager
            
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 🟣 Banner โชว์คำทำนาย
                if showBanner {
                    DailyBannerView(member: currentMember)
                    BuddhistDayBanner()
                    ReligiousHolidayBanner()
                        .environmentObject(language)
                }
                // 🏛️ แนะนำวัดวันนี้
                recommendedTempleSection
                    .padding(.horizontal)
                
                // 📍 สถานที่ใกล้ตัว
                ForEach(nearbyPlaces) { place in
                    VStack(alignment: .leading, spacing: 15) {
                        Label {
                            Text(language.localized("คุณอยู่ใกล้ : \(place.nameTH)", "You’re near : \(place.nameEN)"))
                                .font(.subheadline)
                                .bold()
                                .padding(.bottom)
                        } icon: {
                            Image(systemName: "location.fill")
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            flowManager.currentScreen = .sacredDetail(place: place)
                        }) {
                            Text(language.localized("รายละเอียดสถานที่", "View Details"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical,9)
                                .background(Color.green.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .frame(maxWidth: 600) // ✅ เท่ากับกล่องบน
                    .background(.thinMaterial)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .shadow(radius: 6)
                }
                
                // ✨ Feature Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    MenuButton(titleTH: "แนะนำสถานที่ศักดิ์สิทธิ์รอบจุฬาฯ", titleEN: "Sacred Places around Chula", image: "building.columns", screen: .recommendation)
                    MenuButton(titleTH: "ทำนายเบอร์โทร", titleEN: "Phone Fortune", image: "phone.circle", screen: .phoneFortune)
                    MenuButton(titleTH: "สีเสื้อประจำวัน", titleEN: "Shirt Color", image: "tshirt", screen: .shirtColor)
                    MenuButton(titleTH: "เลขทะเบียนรถ", titleEN: "Car Plate Number", image: "car", screen: .carPlate)
                    MenuButton(titleTH: "เลขที่บ้าน", titleEN: "House Number", image: "house", screen: .houseNumber)
                    MenuButton(titleTH: "ดูดวงไพ่ทาโร่", titleEN: "Tarot Reading", image: "suit.club", screen: .tarot)
                    MenuButton(titleTH: "เซียมซี", titleEN: "Fortune Sticks", image: "scroll", screen: .seamSi)
                    MenuButton(titleTH: "คาถาประจำวัน", titleEN: "Daily Mantra", image: "sparkles", screen: .mantra)
                    MenuButton(titleTH: "เกร็ดความรู้", titleEN: "Knowledge", image: "book.closed", screen: .knowledge)
                    MenuButton(titleTH: "เกม", titleEN: "Games", image: "gamecontroller", screen: .gameMenu)
                    MenuButton(titleTH: "คะแนนแต้มบุญ", titleEN: "Merit Points", image: "star.circle", screen: .meritPoints)
                }
                .padding(.horizontal)
            }
            .padding(.top)
            .onAppear {
                showBanner = true
            }

            .onChange(of: locationManager.userLocation, initial: false) { _, _ in
                checkProximityToSacredPlaces()
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    private var recommendedTempleSection: some View {
        let temple = getRecommendedTemple(for: currentMember)
        let template = getRecommendedTemple(for: currentMember)
        
        return VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(language.localized("แนะนำวัดวันนี้", "Today’s Temple"))
                    .font(.headline)
            } icon: {
                Image(systemName: "building.columns")
                    .foregroundColor(.red)
            }
            
            HStack(spacing: 12) {
                Image(temple.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(language.localized(template.nameTH, template.nameEN))
                        .font(.title3).bold()
                    
                    Text(language.localized(template.descTH, template.descEN))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: 600)
        .background(.thinMaterial)
        .cornerRadius(16)
        .shadow(radius: 6)
    }
}




