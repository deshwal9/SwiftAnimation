//
//  SwiftCompleteTests.swift
//  SwiftCompleteTests
//
//  Created by Ankit kumar on 06/11/24.
//

 // testing framework documentation: https://www.polpiella.dev/swift-testing

import Testing
import Foundation
@testable import SwiftComplete

extension Tag {
    @Tag static var parsing: Self
    @Tag static var errorReporting: Self
    @Tag static var formatting: Self
}

struct SwiftCompleteTests {
   // traits example
    @Test("Check first sample") func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    @Test(.bug("https://www.google.com", "url traits")) func example1() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    // passing the argument into the function
    @Test("odd and even testing", arguments: [4,5,6])
    func example2(value:Int) async throws {
      if value.isMultiple(of: 2) {
            #expect(value.isMultiple(of: 2))
      }else{
           #expect(!value.isMultiple(of: 2))
      }
    }
    // enable the test if the mention condition enable
//    @Test(.enabled(if: AppFeatures.isCommentingEnabled))
//    func videoCommenting() async throws {
//        #expect(AppFeatures.isCommentingEnabled)
//    }
    @Test(.tags(.parsing))
    func example3() {
        
    }
    @Test(.disabled("Flaky, needs investigation before reenabling"))
    func whenParseIsCalledWithAllFields_thenNetworkIsInitialisedCorrectly() {
        // ...
    }
 
    @Test(.disabled("Flaky, needs investigation"), .bug("https://linear.app/project/issue/TEST-431/flaky-test"))
    func whenParseIsCalledWithAllFields_thenNetworkIsInitialisedCorrectly2() {
        // ...
    }
    @Test
    func whenParseIsCalledWithAllFields_thenNetworkIsInitialisedCorrectly3() {
        withKnownIssue {
            #expect(false)
        }
    }
//    @Test(.enabled(when: Config.isCIRun))
//    func whenParseIsCalledWithAllFields_thenNetworkIsInitialisedCorrectly() {
//        // ...
//    }
    
    
    @Test func requiredMacro() async throws {
/// 1 use case  to stop the session
//        try #require(session.invalid)
//        session.invalidate()
/// 2  testing optional value
//        let method  = try #required(paymentMethod.first)
//          #expect(method.isdefault)
    }

    @Test func swiftCompleteExample1() {
            let obj = SpeedWaveVM()

            obj.addSpeedWave(value: 30) { result in
                switch result {
                case .success(let success):
                    // Expect failure for even values
                    #expect(success == true)  // Success should be true (although it's not expected for even values)
                    
                case .failure(let error):
                    // Expect the error to be invalidInput for even values
                    #expect(error == SwiftUIError.invalidInput)  // Expect invalidInput error for even values
                }
            }
        }
    
    // ❌ Avoid checking availability at runtime using #available
    @Test func hasRuntimeVersionCheck() {
        guard #available(macOS 15, *) else { return }

        // ...
    }

    // ✅ Prefer @available attribute on test function
    @Test
    @available(macOS 15, *)
    func usesNewAPIs() {
        // ...
    }
    //-----------------------------------Group related tests into a sub-suite
    
    @Test(.tags(.formatting)) func rating() async throws {
       // #expect(video.contentRating == "G")
    }
    @Test(.tags(.formatting)) func formattedDuration() async throws {
      //  let videoLibrary = try await VideoLibrary()
      //  let video = try #require(await videoLibrary.video(named: "By the Lake"))
    //    #expect(video.formattedDuration == "0m 19s")
    }
    
    
   
}

struct MetadataPresentation {
    let video = Video(fileName: "By the Lake.mov")

    @Test(.tags(.formatting)) func rating() async throws {
        #expect(video.contentRating == "G")
    }

    @Test(.tags(.formatting)) func formattedDuration() async throws {
        let videoLibrary = try await VideoLibrary()
        let video = try #require(await videoLibrary.video(named: "By the Lake"))
        #expect(video.formattedDuration == "0m 19s")
    }
}
