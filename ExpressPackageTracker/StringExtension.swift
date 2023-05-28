//
//  StringExtension.swift
//  ExpressPackageTracker
//
//  Created by MOON on 2023/05/28.
//

import Foundation

extension String{
    
    func pregMatche(pattern: String
                       , options: NSRegularExpression.Options = []
                       , matches: inout [String]) -> Bool {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: options)
            else {
                return false
            }
            let targetStringRange = NSRange(location: 0, length: self.count)
            let results = regex.matches(in: self, options: [], range: targetStringRange)
            for i in 0 ..< results.count {
                for j in 0 ..< results[i].numberOfRanges {
                    let range = results[i].range(at: j)
                    matches.append((self as NSString).substring(with: range))
                }
            }
            return results.count > 0
        }
}
