import XCTest
@testable import Application

final class EdamamNextTest: XCTestCase {
    
    let defaultResponse = """
     {
           "href": "https://www.google.com"
 }
 
 """

    func test_shouldTransformEdamamNextToGenericModel() {
        
        guard let rawData = defaultResponse.data(using: .utf8) else {
            XCTFail("Failed to retrieve raw JSON data")
            return
        }
        
        do {
            
            let sut = try JSONDecoder().decode(EdamamNext.self, from: rawData)
            let entity = sut.toGenericModel()
            XCTAssertEqual(entity.href, "https://www.google.com")
        } catch {
            XCTFail("Failed to convert to generic model")
        }
    }

}
