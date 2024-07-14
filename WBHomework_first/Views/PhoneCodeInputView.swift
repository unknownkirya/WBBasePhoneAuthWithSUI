//
//  PhoneCodeInputView.swift
//  WBHomework_first
//
//  Created by Kirill on 07.07.2024.
//

import SwiftUI

private enum Constants {
    
    static let kFontName = "Montserrat"
    static let kAuthBtnTitle = "Авторизоваться"
    static let kbackBtnTitle = "Вернуться назад"
    
    static let kCornerRadius: CGFloat = 12
    
}

struct PhoneCodeInputView: View {
    
    private let phoneNumber: String
    private let numberOfFields = 4
    private let timer = Timer.publish(every: 1,
                                      on: .main,
                                      in: .common).autoconnect()
    
    @State private var timerCount = 60
    @State private var numbersEnter: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customDarkPurple
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    Image(.sms)
                        .padding(16)
                    Text("\(phoneNumber)")
                        .font(Font.custom(Constants.kFontName, size: 24))
                        .foregroundStyle(.white)
                        .padding([.bottom], 42)
                    SmsVerificationCodeView(numberOfFields: numberOfFields,
                                            otp: $numbersEnter)
                    .padding([.bottom], 45)
                    Text("Запросить повторно через \(timerCount) сек")
                        .foregroundStyle(.white)
                        .padding([.bottom], 24)
                        .onReceive(timer, perform: { _ in
                            if timerCount > 0 {
                                timerCount -= 1
                            }
                        })
                    Button(Constants.kAuthBtnTitle, action: {})
                        .font(Font.custom(Constants.kFontName, size: 16))
                        .foregroundStyle(.white)
                        .frame(width: 352, height: 48)
                        .background(Color.customBasePurple)
                        .cornerRadius(Constants.kCornerRadius)
                        .padding([.bottom], 40)
                    HStack {
                        Image(systemName: "chevron.left")
                            .colorInvert()
                        Button(Constants.kbackBtnTitle, action: { dismiss() })
                            .font(Font.custom(Constants.kFontName, size: 14))
                            .foregroundStyle(.white)
                    }
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [.customDarkPurple, .customBluePurple]),
                                       startPoint: .top,
                                       endPoint: .bottom))
        }
        .navigationBarBackButtonHidden()
    }
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
}

#Preview {
    PhoneCodeInputView(phoneNumber: "+79888888888")
}
