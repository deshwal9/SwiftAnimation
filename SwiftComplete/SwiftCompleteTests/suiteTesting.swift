//
//  suiteTesting.swift
//  SwiftCompleteTests
//
//  Created by Ankit kumar on 31/12/24.
//

import Testing
// it basically treate all the function inside as a test case and there is no need to add a test macro
@Suite("sample suite")
//@Suite(.serialized)  -> this will run the test  in serially if you need
// @Suite(.tags(.parsing)) -> also can add tags to suits
struct suiteTesting {

   func sample1() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
