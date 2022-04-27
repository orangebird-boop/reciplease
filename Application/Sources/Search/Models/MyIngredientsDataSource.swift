import UIKit

class MyIngredientsDataSource: NSObject, UITableViewDataSource {
    let dataStore = MyIngredients()
    
    // TableView data source functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.listOfIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = dataStore.listOfIngredients [indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath as IndexPath)
        cell.textLabel?.text = ingredient
        return cell
    }
}
