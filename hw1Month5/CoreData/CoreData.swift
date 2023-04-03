
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    
}

extension Note {
    
    @nonobjc public class  func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    @NSManaged public var strDrink: String?
//    @NSManaged public var idDrink: Date?
    
}
extension Note: Identifiable {
    
}
//class CoreData {
//
//    static let sharedInstance = CoreData()
//
//    private init () { }
//
//    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
//
//    private let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
//
//    private func deleteObjectFromCoreData(context: NSManagedObjectContext) {
//        do {
//            let object = try context.fetch(fetchRequest)
//            _ = object.map({ context.delete($0) })
//            try context.save()
//        } catch {
//            print("deleting Erroe \(error)")
//        }
//    }
//
//    func saveData(cocktailsName: [Coctails]) {
//        self.container?.performBackgroundTask({ [weak self] (context) in
//            self?.deleteObjectFromCoreData(context: context)
//            self?.saveDataToCoreData(cocktails: cocktailsName, context: context)
//        })
//    }
//
//    private func saveDataToCoreData(cocktails:[Coctails], context: NSManagedObjectContext) {
//
//        context.perform {
//            for cocktail in cocktails {
//                let cocktails = Note(context: context)
//                cocktails.strDrink = cocktail.strDrink
//                cocktails.idDrink = cocktail.idDrink
//                cocktails.strDrinkThumb = cocktail.strDrinkThumb
//            }
//            do {
//                try context.save()
//            } catch {
//                fatalError("fail \(error)")
//            }
//        }
//    }
//
//}
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
func saveContext()
{
    if context.hasChanges
    {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
