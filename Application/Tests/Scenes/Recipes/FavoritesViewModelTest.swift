import XCTest
@testable import Application

final class FavoritesViewModelTest: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    var viewModel: FavoritesViewModel!
    
    
    override func setUp() {
        coreDataManager = CoreDataManager()
        
        coreDataManager.createFavorite(title: "", ingredients: "", totalTime: 1, image: "", url: "") {_ in
        }
        viewModel = FavoritesViewModel(coreDataManager: coreDataManager)
    }
    
    override func tearDown() {
        coreDataManager.deleteAllFavorites()
    }
    
    func test_shouldReturnFavorites() {
        let favorites = viewModel.getRecipes()
        
        XCTAssertEqual(favorites.count, 1)
    }

}
