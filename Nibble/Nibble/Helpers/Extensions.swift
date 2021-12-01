//
//  Extensions.swift
//  Nibble
//
//  Created by Charles Coppieters 't Wallant on 11/30/21.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.2f", self) : String(self)
    }
}
