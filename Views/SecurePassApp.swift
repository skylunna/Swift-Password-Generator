//
//  SecurePassApp.swift
//  
//
//  Created by ztl on 2026/4/27.
//

import SwiftUI

struct ContentView: View {
    // 状态管理：界面数据变化会自动刷新 UI
    @State private var passwordLength = 12
    @State private var useUpper = true
    @State private var useLower = true
    @State private var useNumbers = true
    @State private var useSymbols = false
    @State private var generatedPassword = "点击生成"
    @State private var strength = "未知"
    
    // 实例化逻辑层
    private let generator = PasswordGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                // 1. 密码显示区域
                Section {
                    HStack {
                        Text(generatedPassword)
                            .font(.system(.title2, design: .monospaced)) // 等宽字体更适合密码
                            .textSelection(.enabled) // 允许长按选择
                        Spacer()
                        Button(action: copyToClipboard) {
                            Image(systemName: "doc.on.doc")
                        }
                    }
                } header: {
                    Text("生成的密码")
                }
                
                // 2. 长度滑块
                Section {
                    HStack {
                        Text("长度：\(passwordLength)")
                        Slider(value: $passwordLength, in: 8...32, step: 1)
                    }
                }
                
                // 3. 选项开关
                Section {
                    Toggle("大写字母 (A-Z)", isOn: $useUpper)
                    Toggle("小写字母 (a-z)", isOn: $useLower)
                    Toggle("数字 (0-9)", isOn: $useNumbers)
                    Toggle("特殊符号 (!@#)", isOn: $useSymbols)
                }
                
                // 4. 强度显示
                Section {
                    HStack {
                        Text("密码强度")
                        Spacer()
                        Text(strength)
                            .fontWeight(.bold)
                            .foregroundColor(strengthColor)
                    }
                }
                
                // 5. 生成按钮
                Section {
                    Button(action: generatePassword) {
                        Text("生成新密码")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationTitle("SecurePass")
            .onAppear {
                generatePassword() // 启动时生成一个
            }
        }
    }
    
    // 动作函数
    private func generatePassword() {
        let pwd = generator.generate(
            length: passwordLength,
            useUpper: useUpper,
            useLower: useLower,
            useNumbers: useNumbers,
            useSymbols: useSymbols
        )
        generatedPassword = pwd
        
        strength = generator.checkStrength(
            length: passwordLength,
            useUpper: useUpper,
            useSymbols: useSymbols
        )
    }
    
    private func copyToClipboard() {
        // 注意：UIPasteboard 是 iOS 专属，如果是 Mac 项目需用 NSPasteboard
        // 为了简单起见，这里主要针对 iOS
        UIPasteboard.general.string = generatedPassword
    }
    
    // 根据强度返回颜色
    private var strengthColor: Color {
        switch strength {
        case "弱": return .red
        case "中": return .orange
        case "强": return .green
        default: return .gray
        }
    }
}
