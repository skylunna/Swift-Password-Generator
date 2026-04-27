//
//  PasswordGenerator.swift
//  
//
//  Created by ztl on 2026/4/27.
//

/**
 
    生成密码
 */
import Foundation

struct PasswordGenerator {
    // 字符集定义
    private let lowercase = "abcdefghijklmnopqrstuvwxyz"
    private let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private let numbers = "0123456789"
    private let symbols = "!@#$%^&*()_+-=[]{}|;:,.<>?"
    
    // 生成密码
    func generate(length: Int, useUpper: Bool, useLower: Bool, useNumbers: Bool, useSymbols: Bool) -> String {
        var availableChars = ""
        var password = ""
        
        // 1. 构建可用字符池
        if useLower {
            availableChars += lowercase
        }
        if useUpper {
            availableChars += uppercase
        }
        if useNumbers {
            availableChars += numbers
        }
        if useSymbols {
            availableChars += symbols
        }
        
        // 防止用户没选任何选项
        if availableChars.isEmpty {
            return "请选择至少一种字符类型"
        }
        
        // 2. 随机生成
        for _ in 0..<length {
            let randomIndex = Int.random(int: 0..<availableChars.count)
            let randomChar = availableChars[availableChars.index(availableChars.startIndex, offsetBy: randomIndex)]
            password.append(randomChar)
        }
        
        return password
    }
    
    // 3. 简单的强度检测逻辑
    func checkStrength(length: Int, useUpper: Bool, useSymbols: bool) -> String {
        if length < 8 {
            return "弱"
        }
        if length < 12 && !useSymbols {
            return "中"
        }
        return "强"
    }
    
}
