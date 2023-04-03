//
//  LikedViewController.swift
//  hw1Month5
//
//  Created by Mac on 28/3/2023.
//

import UIKit
import FirebaseAuth
import CoreData

var noteList = [Note]()

class BusketViewController: UIViewController, UpdateTableViewDelegate {
  
    static let id = String(describing: BusketViewController.self)
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let collection = "Coktails"
    private let document = "Students"
    private let phineNumber = "+996504372312"
    private var verificationID:  String?
    private var viewModel = CocktailsListViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var note:[Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authetificatePN()
        DataBaseManager.shared.setTo(collection: collection,
                                     document: document, withData: ["hw": 8])
        congigureTV()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private func loadData() {
        viewModel.retrieveDataFromCoreData()
    }
    
  func reloadData(sender: CocktailsListViewModel) {
      self.tableView.reloadData()
}

    private func congigureTV() {
        self.viewModel.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: BusketTableViewCell.id, bundle: nil), forCellReuseIdentifier: BusketTableViewCell.id)
        loadData()
    }
    
    private func authetificatePN() {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phineNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.verificationID = verificationID
            }
    }
    
    func getAllItems() {
        do {
            note = try context.fetch(Note.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    func createItems(name: String) {
        let newItem = Note(context: context)
        newItem.strDrink = name
        
        do {
           try context.save()
        } catch {
        }
    }
    func deleteItems(item: Note) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func updateItems(item: Note, newName: String) {
        item.strDrink = newName
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension BusketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 100
    }
}

extension BusketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
         numberOfRowsInSection section: Int
      ) -> Int {
        return noteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusketTableViewCell.id, for: indexPath
        ) as! BusketTableViewCell
        let model = note[indexPath.row]
        cell.display(item: model)
        return cell
    }
}
