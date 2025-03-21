//
//  Array+Extensions.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    func randomElement(where predicate: (Element) -> Bool) -> Element? {
        let filteredArray = filter(predicate)
        return filteredArray.isEmpty ? nil : filteredArray.randomElement()
    }
}
