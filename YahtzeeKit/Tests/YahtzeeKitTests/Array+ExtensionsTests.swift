//
//  Array+ExtensionsTests.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/16/25.
//

import Testing
@testable import YahtzeeKit

struct ArrayExtensionsTests {
    @Test func safeSubscript() {
        // Given
        let array = ["a", "b", "c"]

        // Then
        #expect(array[safe: 0] == "a")
        #expect(array[safe: 1] == "b")
        #expect(array[safe: 2] == "c")
        #expect(array[safe: 3] == nil)
        #expect(array[safe: -1] == nil)
    }

    @Test func randomElement() {
        // Given
        var array = ["a", "b", "c"]

        // Then
        #expect(array.randomElement(where: { $0 == "b" }) == "b")
        #expect(array.randomElement(where: { $0 == "not found" }) == nil)

        // When
        array.removeAll()

        // Then
        #expect(array.randomElement(where: { $0 == "b" }) == nil)
    }
}
