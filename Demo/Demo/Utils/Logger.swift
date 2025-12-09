//
//  Logger.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 5. 12. 2025..
//

import Foundation

enum Log {
    static func debug(_ message: @autoclosure () -> Any,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line)
    {
#if DEBUG
        let filename = (file as NSString).lastPathComponent
        print("[DEBUG] \(filename):\(line) \(function) — \(message())")
#endif
    }
}
