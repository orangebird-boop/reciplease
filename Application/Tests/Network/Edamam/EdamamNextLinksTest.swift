import XCTest
@testable import Application

final class EdamamNextLinksTest: XCTestCase {
    let defaultResponse = """
 {
      "next":{
         "href": "https://www.google.com",
        
      }
 }
 """

    func test_shouldTransformEdamamNextLinksToGenericModel() {
        
        guard let rawData = defaultResponse.data(using: .utf8) else {
            XCTFail("Failed to retrieve raw JSON data")
            return
        }
        
        do {
            
            let sut = try JSONDecoder().decode(EdamamNextLinks.self, from: rawData)
            let entity = sut.toGenericModel()
            XCTAssertEqual(entity.next.href, "https://www.google.com")
        } catch {
            XCTFail("Failed to convert to generic model")
        }
    }

}
