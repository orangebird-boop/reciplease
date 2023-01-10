import XCTest
@testable import Application
import Alamofire


final class EdamamSearchServiceTest: XCTestCase {
	
	let defaultResponse = """
 {
   "from": 1,
   "to": 1,
   "count": 1,
   "_links": {
  "self": {
 "href": "string",
 "title": "string"
  },
  "next": {
 "href": "string",
 "title": "string"
  }
   },
   "hits": [
  {
 "recipe": {
   "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_f44b191fb71d806ddd1358f30dcc6e22",
   "label": "Natto Spring Rolls",
   "image": "image",
   "images": {
  "THUMBNAIL": {
 "url": "string",
 "width": 0,
 "height": 0
  },
  "SMALL": {
 "url": "string",
 "width": 0,
 "height": 0
  },
  "REGULAR": {
 "url": "string",
 "width": 0,
 "height": 0
  },
  "LARGE": {
 "url": "string",
 "width": 0,
 "height": 0
  }
   },
   "source": "string",
   "url": "string",
   "shareAs": "string",
   "yield": 0,
   "dietLabels": [
  "string"
   ],
   "healthLabels": [
  "string"
   ],
   "cautions": [
  "string"
   ],
   "ingredientLines": [
  "string"
   ],
   "ingredients": [
  {
 "text": "string",
 "quantity": 0,
 "measure": "string",
 "food": "string",
 "weight": 0,
 "foodId": "string"
  }
   ],
   "calories": 0,
   "glycemicIndex": 0,
   "totalCO2Emissions": 0,
   "co2EmissionsClass": "A+",
   "totalWeight": 0,
   "cuisineType": [
  "string"
   ],
   "mealType": [
  "string"
   ],
   "dishType": [
  "string"
   ],
   "instructions": [
  "string"
   ],
   "tags": [
  "string"
   ],
   "externalId": "string",
   "totalNutrients": {},
   "totalDaily": {},
   "digest": [
  {
 "label": "string",
 "tag": "string",
 "schemaOrgTag": "string",
 "total": 0,
 "hasRDI": true,
 "daily": 0,
 "unit": "string",
 "sub": {}
  }
   ]
 },
 "_links": {
   "self": {
  "href": "https://api.edamam.com/api/recipes/v2/f44b191fb71d806ddd1358f30dcc6e22?type=public&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5",
  "title": "string"
   },
   "next": {
  "href": "",
  "title": ""
   }
 }
  }
   ]
 }
 """
	
	private var searchService: EdamamSearchService!
	
	override func setUp() {
		searchService = EdamamSearchService()
		
		URLProtocol.registerClass(MockURLProtocol.self)
		
		let configuration = URLSessionConfiguration.af.default
		configuration.protocolClasses = [MockURLProtocol.self]
		
		Alamofire.Session(configuration: configuration)
	}
	
	override func tearDown() {
		MockURLProtocol.mockData = nil
	}
	
	func testShouldReturnJSONPayloadWhenRequestingRecipe() {
		MockURLProtocol.mockData = defaultResponse.data(using: .utf8)
		
		searchService.getRecipes(ingredients: []) { result in
			switch result {
			case .success(let success):
				XCTAssertEqual(success.recipes.count, 1)
				
			case .failure:
				XCTFail("Failed to retrieve mocked JSON")
			}
		}
	}
}
