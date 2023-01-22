import XCTest
@testable import Application

final class EdamamIngredientTest: XCTestCase {

    let defaultResponse = """


               {
                 "text": "2 packs natto, about 1.5 oz each",
                 "quantity": 1.5,
                 "measure": "ounce",
                 "food": "natto",
                 "weight": 42.5242846875,
                 "foodId": "food_a9i5k23ajal45xacaqy73byxvswn",
               }

"""
    func test_shouldTransformEdamamNextToGenericModel() {
        
        guard let rawData = defaultResponse.data(using: .utf8) else {
            XCTFail("Failed to retrieve raw JSON data")
            return
        }
        
        do {
            
            let sut = try JSONDecoder().decode(EdamamIngredient.self, from: rawData)

            let entity = sut.toGenericModel()
            XCTAssertEqual(entity.text, "2 packs natto, about 1.5 oz each")
        } catch {
            XCTFail("Failed to convert to generic model")
        }
    }
}
