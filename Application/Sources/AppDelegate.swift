import UIKit
import Alamofire
import CoreData

//var app: AppDelegate {
//    // swiftlint:disable:next force_cast
//    UIApplication.shared.delegate as! AppDelegate
//}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // swiftlint:disable:next identifier_name
    var db: CoreDataManager!
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        db = CoreDataManager()
//        
//        
//        // Importer of recipies Begin
//        let viewContext = db.persistentContainer.viewContext
//        
//        var recipe1 = RecipeEntity(entity: RecipeEntity.entity(), insertInto: viewContext)
//        recipe1.nameAttribute = ""
//        
//        db.saveContext()
//        
//        // Importer of recipies End
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()

        self.window = window
        return true
    }
}


