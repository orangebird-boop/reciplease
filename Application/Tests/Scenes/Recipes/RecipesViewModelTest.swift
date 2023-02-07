import XCTest
@testable import Application

final class RecipesViewModelTest: XCTestCase {
    
    let defaultResponseWithNextURL = """
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
         "href": "http://www.google.com",
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
    
    let defaultResponseWithoutNextURL = """
{
   "from":1,
   "to":1,
   "count":1,
   "_links":{
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
    
    var viewModel: RecipesViewModel!
    
    var service: EdamamSearchService!
    var stubNetworkManager: StubNetworkManager!
    var observer: RecipesViewModelObserver!
    
    
    override func setUp() {
        stubNetworkManager = StubNetworkManager()
        service = EdamamSearchService(networkService: stubNetworkManager)
        
        observer = RecipesViewModelObserver()
        viewModel = RecipesViewModel(recipes: [Recipe(name: "Title", foodImage: "image", url: "http://www.google.com", ingredientLines: [], totalTime: 1)])
        viewModel.delegate = observer
        
    }
    
        func test_ShouldGetRecipes() {
            viewModel = RecipesViewModel(searchService: service, recipes: [Recipe(name: "Title", foodImage: "image", url: "http://www.google.com", ingredientLines: [], totalTime: 1)], nextURL: "Test")
            viewModel.delegate = observer
            stubNetworkManager.stubData = try! JSONDecoder().decode(EdamamResponse.self, from: defaultResponseWithNextURL.data(using: .utf8)!)
            let recipes = viewModel.getRecipes()
            
            XCTAssertEqual(recipes.count, 1)
        }
    
    
    func test_ShouldLoadMoreRecipes() {
        viewModel = RecipesViewModel(searchService: service, recipes: [Recipe(name: "Title", foodImage: "image", url: "http://www.google.com", ingredientLines: [], totalTime: 1)], nextURL: "Test")
        viewModel.delegate = observer
        stubNetworkManager.stubData = try! JSONDecoder().decode(EdamamResponse.self, from: defaultResponseWithNextURL.data(using: .utf8)!)
        viewModel.loadMoreRecipes()
        
        XCTAssertTrue(observer.foundRecipes)
        XCTAssertEqual(viewModel.nextURL, "http://www.google.com")
    }
    
    func test_ShouldNotLoadMoreRecipesIfNextURLFromInit() {
        viewModel.loadMoreRecipes()
        XCTAssertTrue(observer.noMoreToLoad)
    }
    
    func test_ShouldNotLoadMoreRecipesIfNoURLFromAPI() {
        viewModel = RecipesViewModel(searchService: service, recipes: [Recipe(name: "Title", foodImage: "image", url: "http://www.google.com", ingredientLines: [], totalTime: 1)],nextURL: "test")
        viewModel.delegate = observer
        stubNetworkManager.stubData = try! JSONDecoder().decode(EdamamResponse.self, from: defaultResponseWithoutNextURL.data(using: .utf8)!)
        viewModel.loadMoreRecipes()
        
        XCTAssertTrue(observer.foundRecipes)
        XCTAssertNil(viewModel.nextURL)
        
        viewModel.loadMoreRecipes()
        
        XCTAssertTrue(observer.noMoreToLoad)
    }
    
    class RecipesViewModelObserver: RecipesViewModelDelegate {
        
        var foundRecipes = false
        var noMoreToLoad = false
        
        func didFindRecipes() {
            foundRecipes = true
        }
        
        func noMoreRecipesToLoad() {
            noMoreToLoad = true
        }
        
        
    }
}
