import XCTest
@testable import Application

final class CoreDataManagerTest: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    
    
    override func setUp() {
        coreDataManager = CoreDataManager()
        
        coreDataManager.createFavorite(title: "Title", ingredients: "apple", totalTime: 1, image: "image", url: "http://www.google.com") {_ in
        }
        
    }
    
    override func tearDown() {
        coreDataManager.deleteAllFavorites()
    }
    
    func test_ShouldCreateFavorite() {
        coreDataManager.saveContext()
        
        let recipeIsFavorite = coreDataManager.checkIfRecipeFavorite(name: "Title", url: "http://www.google.com")
      
        XCTAssertEqual(coreDataManager.getFavorites().count, 1)
    }
    
    func test_ifRecipeIsFavorite() {
        XCTAssertTrue(coreDataManager.checkIfRecipeFavorite(name: "Title", url: "http://www.google.com"))
    }
    
    func test_deleteFavorite(){
        coreDataManager.createFavorite(title: "Title2", ingredients: "apple, pen", totalTime: 2, image: "image", url: "http://www.facebook.com") {_ in
        }
        coreDataManager.saveContext()
        coreDataManager.deleteFavorite(name: "Title2", url: "http://www.facebook.com") {_ in
        }
        coreDataManager.saveContext()
            
        XCTAssertEqual(coreDataManager.getFavorites().count, 1)
        XCTAssertTrue(coreDataManager.checkIfRecipeFavorite(name: "Title", url: "http://www.google.com"))
    }
    
    func test_deleteAllFavorites() {
        coreDataManager.createFavorite(title: "Title2", ingredients: "apple, pen", totalTime: 2, image: "image", url: "http://www.facebook.com") {_ in
        }
        coreDataManager.saveContext()
        coreDataManager.deleteAllFavorites()
        coreDataManager.saveContext()
        
        XCTAssertEqual(coreDataManager.getFavorites().count, 0)
    }
}
