import Foundation

class SearchResultViewModel {
    var recipes: [Recipe] = []
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
    
//    private lazy var dataSource = makeDataSource()
//    
//    func updateDataSource() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, EdamamRecipe>()
//        snapshot.appendSections([.first])
//    }
//    
//    enum Section {
//        case first
//    }
//    
//    typealias DataSource = UITableViewDiffableDataSource<Section, EdamamRecipe>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, EdamamRecipe>
//    
//    func applySnapshot(animatingDifferences: Bool = true) {
//        var snapshot = Snapshot()
//        
//        snapshot.appendSections([.first])
//        
//        snapshot.appendItems(viewModel.recipes)
//        
//        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
//    }
}
