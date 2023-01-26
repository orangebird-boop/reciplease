import XCTest
@testable import Application

final class EdamamRecipeTest: XCTestCase {
 
    let defaultResponse = """
    {
    "label": "test",
    "url": "http://www.google.com",
    "ingredientLines": [
    "2 packs natto, about 1.5 oz each",
    "1 tablespoon dried wakame (about 1/4 cup rehydrated), finely chopped",
    "1 green onion, finely chopped",
    "For seasoning the natto:",
    "1/2 teaspoon light soy sauce",
    "1/4 teaspoon sugar",
    "1/4 teaspoon hot mustard",
    "12 spring roll wrappers",
    "1 teaspoon cornstarch mixed with 2 tablespoons water",
    "2 cups vegetable oil, for frying"
    ]
    }
"""
    
    func test_shouldTransformEdamamRecipeToGenericModel() {
        
        guard let rawData = defaultResponse.data(using: .utf8) else {
            XCTFail("Failed to retrieve raw JSON data")
            return
        }
        
        do {
            
            let sut = try JSONDecoder().decode(EdamamRecipe.self, from: rawData)
            let entity = sut.toGenericModel()
            print(entity)
            XCTAssertEqual(entity.ingredientLines.count, 10)
        } catch {
            XCTFail("Failed to convert to generic model")
        }
    }
}


