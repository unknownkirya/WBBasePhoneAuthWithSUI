//
//  ContentView.swift
//  WBHomework_first
//
//  Created by Kirill on 02.07.2024.
//

import SwiftUI

private enum Constants {
    
    static let kPhonePlaceholder = "+7 (___) ___ - __ - __"
    static let kFontName = "Montserrat"
    static let kAuthLblTitle = "Авторизация"
    static let kEnterByPhoneNumberLblTitle = "Вход по номеру телефона"
    static let kRequesCodeBtnTitle = "Запросить код"
    
    static let kCornerRadius: CGFloat = 12
    
}

struct MainAuthorizationView: View {
    
    @State private var number = ""
    @State private var isCorrectRussianPhone = false
    @State private var needToShowErrorBorderOnTxtField = false
    
    private let phonePlaceholder = Constants.kPhonePlaceholder
    
    struct RequestCodeButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(Font.custom(Constants.kFontName, size: 16))
                .foregroundStyle(.white)
                .background(configuration.isPressed ? Color.customPressedPurple : Color.customBasePurple)
                .frame(width: 352, height: 48)
                .background(Color.customBasePurple)
                .cornerRadius(Constants.kCornerRadius)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customDarkPurple
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    Text(Constants.kAuthLblTitle)
                        .font(Font.custom(Constants.kFontName, size: 24))
                        .foregroundStyle(.white)
                        .padding([.bottom], 28)
                        .padding([.top], 40)
                    Image(.mockIcon)
                        .padding([.bottom], 16)
                    Text(Constants.kEnterByPhoneNumberLblTitle)
                        .font(Font.custom(Constants.kFontName, size: 16))
                        .foregroundStyle(.white)
                        .padding([.bottom], 32)
                    VStack {
                        if needToShowErrorBorderOnTxtField {
                            Text("Некорректный формат номера")
                                .multilineTextAlignment(.leading)
                                .font(Font.custom(Constants.kFontName, size: 12))
                                .foregroundStyle(.red)
                                .padding(.top, 10)
                                .padding(.leading, -140)
                        }
                        TextField(phonePlaceholder,
                                  text: $number,
                                  prompt: Text(phonePlaceholder).foregroundColor(.white))
                            .onChange(of: number, perform: { newValue in
                                if number.count == 1 { number = "+7" + newValue.formatPhoneNumber() }
                                number = number.isEmpty ? "+7" : number.formatPhoneNumber()
                                isCorrectRussianPhone = number.isCorrectRussianPhoneNumber
                                needToShowErrorBorderOnTxtField = false
                            })
                            .padding(.top, needToShowErrorBorderOnTxtField ? 0 : 14)
                            .padding(.bottom, 14)
                            .padding(.leading, 16)
                            .foregroundStyle(.white)
                            .keyboardType(.numberPad)
                    }
                        .frame(width: 352, height: 48)
                        .background(Color.customPhoneTextFieldPurple)
                        .cornerRadiusWithBorder(radius: Constants.kCornerRadius,
                                                isHidden: !$needToShowErrorBorderOnTxtField.wrappedValue)
                        .padding(.bottom, 24)
                    if $isCorrectRussianPhone.wrappedValue {
                        NavigationLink(destination: PhoneCodeInputView(phoneNumber: number)) {
                            Text(Constants.kRequesCodeBtnTitle)
                        }
                        .buttonStyle(RequestCodeButtonStyle())
                        .padding([.bottom], 40)
                    }
                    else {
                        Button(Constants.kRequesCodeBtnTitle, action: {
                            needToShowErrorBorderOnTxtField = true
                            print($isCorrectRussianPhone.wrappedValue)
                        })
                        .font(Font.custom(Constants.kFontName, size: 16))
                        .foregroundStyle(.white)
                        .frame(width: 352, height: 48)
                        .background(Color.customBasePurple)
                        .cornerRadius(Constants.kCornerRadius)
                        .padding([.bottom], 40)
                    }
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [.customDarkPurple, .customBluePurple]), 
                                       startPoint: .top,
                                       endPoint: .bottom))
        }
    }
    
    private func validateRussianPhoneA(phoneString: String) -> Bool {
        phoneString.isCorrectRussianPhoneNumber
    }
    
}

#Preview {
    MainAuthorizationView()
}
