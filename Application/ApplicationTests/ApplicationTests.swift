import XCTest
@testable import Application

class ApplicationTests: XCTestCase {

    func testEdamamSearchService() throws {
        let sut = EdamamSearchService()
        let result = sut.buildUrl(for: ["haha", "itsnoturl"])
        XCTAssertEqual(result, "https://api.edamam.com/api/recipes/v2?type=public&q=haha%20itsnoturl&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5")
    }

}
