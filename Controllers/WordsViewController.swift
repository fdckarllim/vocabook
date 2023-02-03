//
//  LearningViewController.swift
//  vocabook
//
//  Created by Karl Lim on 1/27/23.
//

import UIKit

class WordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var navbarHeight: CGFloat?
    var wordList: [Word] = [
        Word(name: "cat", description: "this is asdf asdfa sdfhasmdf hajskdfm ansjkdfan skdfnaklsd fjaklsdfj aslkdfj asdfdesc 1"),
        Word(name: "dog", description: "desc 2")
    ]
    
    private let floatingButton: UIButton = {
        let image = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 32,
                weight: .medium
            )
        )
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapView(_ :)), for: .touchUpInside)

        return button
    }()
    
    // - add table view placeholder
//    let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//    let label = UILabel(frame: CGRect(x: 0, y: 0, width: emptyView.bounds.size.width, height: emptyView.bounds.size.height))
//    label.text = "No data available"
//    label.textAlignment = .center
//    emptyView.addSubview(label)
//    tableView.backgroundView = emptyView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() 
        
        self.navigationController?.navigationBar.topItem?.title = "Vocabulary Book"
        
        view.addSubview(floatingButton)
        wordList.sort {
            $0.name < $1.name
        }

        // - set title
//        let label = UILabel()
//        label.text = "Word"
//        label.textAlignment = .left
//
//        self.navigationController?.navigationBar.topItem?.titleView = label
//        navbarHeight = self.navigationController?.navigationBar.frame.size.height
        navbarHeight = self.tabBarController?.tabBar.frame.size.height


        // - register table view
        let nib = UINib(nibName: "LearningMenuTableViewCell", bundle: nil)
//        self.tableView.separatorColor = UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1)
        self.tableView.register(nib, forCellReuseIdentifier: "LearningMenuTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navheight = navbarHeight ?? 0
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 60 - 8,
            y: view.frame.size.height - navheight - 60 - 8,
            width: 60,
            height: 60
        )
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("TAP TAP TAP")
        let alert = UIAlertController(title: "Create new", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default)
        let okAction = UIAlertAction(title: "SAVE", style: .default, handler: {_ in
            
            let firstTextField = alert.textFields![0] as UITextField
            let secondTextField = alert.textFields![1] as UITextField
            let name = firstTextField.text ?? ""
            let description = secondTextField.text ?? ""
            
            if (name.count > 0 && description.count > 0 ) {
                self.wordList.append(Word(name: name, description: description))
                self.wordList.sort {
                    $0.name < $1.name
                }
                self.tableView?.reloadData()
            }
            
            print(firstTextField.text ?? "")
            print(secondTextField.text ?? "")
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter a vocabulary"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter the meaning"
        }
        
        

        self.present(alert, animated: false)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        
        counterLbl.text = "\(self.wordList.count) words"
        
        let count = self.wordList.count // Get the count of the number of rows
//        emptyView.isHidden = count != 0
        return count

        
        return self.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        var cell = UITableViewCell()
        
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: "LearningMenuTableViewCell", for: indexPath) as? LearningMenuTableViewCell {
            itemCell.nameLbl.text = wordList[indexPath.row].name
            itemCell.descriptionLbl.text = wordList[indexPath.row].description
            cell = itemCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let word = wordList[indexPath.row].name
        let description = wordList[indexPath.row].description
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let wordDetailViewCtrl = mainStoryBoard.instantiateViewController(withIdentifier: "WordDetailViewController") as! WordDetailViewController
        wordDetailViewCtrl.myWord = wordList[indexPath.row]
        
        print(word)
        print(description)
        
        self.navigationController?.pushViewController(wordDetailViewCtrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath)
        print("DESELECT ")
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        print(editingStyle)
//        print(indexPath)
//    }
    
//    private func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UIContextualAction]? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { a,indexPath,test in
//            print(a)
//            print(indexPath)
//            print(test)
//        }
//
//        return [deleteAction]
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print(">>> Trying to swipe row \(indexPath.row)")
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            print(">>> 'Delete' clicked on \(indexPath.row)")
//            print(action)
//            print(view)
            //            print(handler)
                        print(indexPath)
            self.wordList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            print(">>> 'Edit' clicked on \(indexPath.row)")
            
            let wordValue = self.wordList[indexPath.row].name
            let descValue = self.wordList[indexPath.row].description
            
            let alert = UIAlertController(title: "Edit vocabulary", message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "CANCEL", style: .default)
            let okAction = UIAlertAction(title: "SAVE", style: .default, handler: {_ in
                
                let wordTextField = alert.textFields![0] as UITextField
                let descTextField = alert.textFields![1] as UITextField
                let word = wordTextField.text ?? ""
                let description = descTextField.text ?? ""
                
                if (word.count > 0 && description.count > 0 ) {
                    self.wordList[indexPath.row].name = word
                    self.wordList[indexPath.row].description = description
                    self.wordList.sort {
                        $0.name < $1.name
                    }
                    self.tableView?.reloadData()
                }
                
                print(wordTextField.text ?? "")
                print(descTextField.text ?? "")
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addTextField { (textField) in
                textField.text = wordValue
                textField.placeholder = "Enter a vocabulary"
            }
            alert.addTextField { (textField) in
                textField.text = descValue
                textField.placeholder = "Enter the meaning"
            }

            self.present(alert, animated: false)
        }
        
        editAction.backgroundColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1.00)
        deleteAction.backgroundColor = UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }

//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return wordList[indexPath.row] == "Expanded"
//        return true
//    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
