
import CoreData
import UIKit

protocol UpdateTableViewDelegate: NSObjectProtocol {
    func reloadData(sender: CocktailsListViewModel)
    
}
class CocktailsListViewModel: NSObject, NSFetchedResultsControllerDelegate {
    
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private var fetchResultsController: NSFetchedResultsController<Note>?
    
    weak var delegate: UpdateTableViewDelegate?
    
    func retrieveDataFromCoreData() {
        if let context = self.container?.viewContext {
            let request = Note.fetchRequest() as! NSFetchRequest<Note>
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Note.strDrink), ascending: false)]
            self.fetchResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                     managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController?.delegate = self
            do {
                try self.fetchResultsController?.performFetch()
                
            } catch {
                print("erroe \(error)")
            }
        }
    }
        func controllerDidChangeContent(_ controller: NSFetchedResultsController <NSFetchRequestResult> ) {
            self.delegate?.reloadData(sender: self)
        }
        func numberOfRowsInSection(section: Int) -> Int {
            return fetchResultsController?.sections?[section].numberOfObjects ?? 0
            
        }
        func object (indexPath: IndexPath) -> Note? {
            return fetchResultsController?.object(at: indexPath)
        }
    }
