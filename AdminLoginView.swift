import SwiftUI

struct AdminLoginView: View {
    @EnvironmentObject var flowManager: MuTeLuFlowManager
    @EnvironmentObject var language: AppLanguage
    
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    
    let correctUsername = "admin"
    let correctPassword = "123456"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("🔐 \(language.localized("เข้าสู่ระบบผู้ดูแล", "Admin Login"))")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                VStack(spacing: 16) {
                    TextField(language.localized("ชื่อผู้ใช้", "Username"), text: $username)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    SecureField(language.localized("รหัสผ่าน", "Password"), text: $password)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                }
                
                if showError {
                    Text(language.localized("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง", "Incorrect username or password"))
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }
                
                Button(action: {
                    if username == correctUsername && password == correctPassword {
                        flowManager.currentScreen = .admin
                    } else {
                        showError = true
                    }
                }) {
                    Text(language.localized("เข้าสู่ระบบ", "Login"))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        flowManager.currentScreen = .login
                    }) {
                        Label(language.localized("ย้อนกลับ", "Back"), systemImage: "chevron.left")
                    }
                }
            }
        }
    }
}
