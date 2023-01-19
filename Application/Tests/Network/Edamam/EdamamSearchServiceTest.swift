import XCTest
@testable import Application

final class EdamamSearchServiceTest: XCTestCase {
    let defaultResponse = """
{
   "from":1,
   "to":1,
   "count":1,
   "_links":{
      "self":{
         "href":"string",
         "title":"string"
      },
      "next":{
         "href": "string",
         "title":"string"
      }
   },
   "hits":[
      {
         "recipe":{
            "uri":"http://www.edamam.com/ontologies/edamam.owl#recipe_f44b191fb71d806ddd1358f30dcc6e22",
            "label":"Natto Spring Rolls",
            "image":"image",
            "images":"image",
            "source":"string",
            "url":"string",
            "ingredientLines":[
               "natto"
            ],
            "ingredients":[
               {
                  "text":"natto",
                  "foodId":"string"
               }
            ]
         },
         "_links":{
            "self":{
               "href":"https://api.edamam.com/api/recipes/v2/f44b191fb71d806ddd1358f30dcc6e22?type=public&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5",
               "title":"string"
            },
            "next":{
               "href":"",
               "title":""
            }
         }
      }
   ]
}
"""
    
    var service: EdamamSearchService!
    var stubNetworkManager: StubNetworkManager!
    
    override func setUp() {
        stubNetworkManager = StubNetworkManager()
        service = EdamamSearchService(networkService: stubNetworkManager)
    }
    
    func test_ShouldReturnResponseFromNetworkCallNextSet() {
        stubNetworkManager.stubData = try! JSONDecoder().decode(EdamamResponse.self, from: defaultResponse.data(using: .utf8)!)
        
        service.getRecipes(nextSet: "string") { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure:
                XCTFail("It shouldn't fail")
            }
        }
    }
    
    func test_ShouldReturnResponseFromNetworkCall() {
        stubNetworkManager.stubData = try! JSONDecoder().decode(EdamamResponse.self, from: defaultResponse.data(using: .utf8)!)
        
        service.getRecipes(ingredients: []) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure:
                XCTFail("It shouldn't fail")
            }
        }
    }
    
    func test_ShouldReturnErrorInvalidURL() {
        stubNetworkManager.stubError = NetworkManagerError.invalidURL
        
        service.getRecipes(ingredients: []) { result in
            switch result {
            case .success:
                XCTFail("It should not fail")
            case .failure(let error):
                XCTAssertEqual(error as! SearchServiceError, SearchServiceError.networkError)
            }
        }
    }
    
    func test_ShouldReturnnetworkError() {
        stubNetworkManager.stubError = NetworkManagerError.emptyData
        
        service.getRecipes(ingredients: []) { result in
            switch result {
            case .success:
                XCTFail("It should not fail")
            case .failure(let error):
                XCTAssertEqual(error as! SearchServiceError, SearchServiceError.networkError)
            }
        }
    }
    
    func test_shouldBUildURL() {
        let ingredients = ["natto"]
        
        let url = service.buildUrl(for: ingredients)
            
        XCTAssertTrue(url!.contains("natto"))
    }
}
