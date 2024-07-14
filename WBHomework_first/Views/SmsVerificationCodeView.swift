//
//  SmsVerificationCodeView.swift
//  WBHomework_first
//
//  Created by Kirill on 11.07.2024.
//

import SwiftUI
import Combine

private enum Constants {
    
    static let kErrorLblText = "Неверный пароль"
    static let kFontName = "Montserrat"
    
}

struct SmsVerificationCodeView: View {
    
    var numberOfFields: Int = 4
    
    @FocusState private var pinFocusState: FocusPin?
    @Binding private var otp: String
    @State private var pins: [String]
    @State private var borderColor = Color.clear
    @State private var needToShowUnderlineError = false
    
    private let correctCode = "1234"
    
    enum FocusPin: Hashable {
        case pin(Int)
    }
    
    init(numberOfFields: Int, otp: Binding<String>) {
        self.numberOfFields = numberOfFields
        self._otp = otp
        self._pins = State(initialValue: Array(repeating: "", count: numberOfFields))
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                ForEach(0..<numberOfFields, id: \.self) { index in
                    TextField("", text: $pins[index])
                        .modifier(OtpModifier(pin: $pins[index]))
                        .foregroundColor(Color.white)
                        .onChange(of: pins[index]) { newVal in
                            if newVal.count == 1, index < numberOfFields - 1 {
                                pinFocusState = FocusPin.pin(index + 1)
                            }
                            else if newVal.count == numberOfFields {
                                // Pasted value
                                otp = newVal
                                updatePinsFromOTP()
                                pinFocusState = FocusPin.pin(numberOfFields - 1)
                            }
                            else if newVal.isEmpty {
                                if index > 0 {
                                    pinFocusState = FocusPin.pin(index - 1)
                                }
                            }
                            
                            updateOTPString()
                            
                            if otp.count == numberOfFields {
                                
                            }
                        }
                        .focused($pinFocusState, equals: FocusPin.pin(index))
                        .onTapGesture {
                            // Set focus to the current field when tapped
                            pinFocusState = FocusPin.pin(index)
                        }
                        .cornerRadiusWithBorder(radius: 12, isHidden: false, borderColor: borderColor)
                }
            }
            .padding([.bottom], 12)
            Text(Constants.kErrorLblText)
                .foregroundStyle(.red)
                .font(Font.custom(Constants.kFontName, size: 14))
                .opacity(needToShowUnderlineError ? 1 : 0)
        }
        .onAppear {
            // Initialize pins based on the OTP string
            updatePinsFromOTP()
        }
    }
    
    private func updatePinsFromOTP() {
        let otpArray = Array(otp.prefix(numberOfFields))
        for (index, char) in otpArray.enumerated() {
            pins[index] = String(char)
        }
    }
    
    private func updateOTPString() {
        otp = pins.joined()
        
        if otp.count == 4 {
            if otp != correctCode {
                needToShowUnderlineError = true
                borderColor = .red
            } else {
                needToShowUnderlineError = false
                borderColor = .green
            }
        } else {
            needToShowUnderlineError = false
            borderColor = .clear
        }
    }
}

struct OtpModifier: ViewModifier {
    @Binding var pin: String
    
    var textLimit = 1
    
    func limitText(_ upper: Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) { _ in limitText(textLimit) }
            .frame(width: 64, height: 80)
            .font(.system(size: 36))
            .background(Color.customPhoneTextFieldPurple)
    }
    
}

struct OTPFieldView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 8) {
            SmsVerificationCodeView(numberOfFields: 4, otp: .constant(""))
                .previewLayout(.sizeThatFits)
        }
    }
    
}

//#Preview {
//    OTPFieldView(numberOfFields: 4, otp: )
//}
