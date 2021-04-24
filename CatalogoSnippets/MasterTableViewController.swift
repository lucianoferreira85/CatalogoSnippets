//
//  MasterTableViewController.swift
//  CatalogoSnippets
//
//  Created by Luciano Ferreira on 25/03/21.
//

import UIKit

protocol SnippetSelectionDelegate: AnyObject {
    func snippetSelected(_ newSnippet: Snippet)
}

class MasterTableViewController: UITableViewController {
    @IBOutlet weak var btAddSnippet: UIBarButtonItem!
    
    weak var delegate: SnippetSelectionDelegate?
    var selectedTag: Tag = Tag(title: "Networking")
    var snippets: [Snippet] = [
        Snippet(tag: Tag(title: "Networking"), name: "Snippet 1", content: "let x = 10"),
        Snippet(tag: Tag(title: "Persistência"), name: "Snippet 2", content: "let y = true"),
        Snippet(tag: Tag(title: "Networking"), name: "Snippet 3", content: "let z = \"abc\"")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var tfName: UITextField!
    
    @IBAction func addNewSnippet(_ sender: Any) {
        snippets.append(Snippet(tag: selectedTag, name: "Snippet \(snippets.count+1)", content: "let a = \(snippets.count)"))
        tableView.reloadData()
        /*
        let alert = UIAlertController(title: "Add Snippet", message: "Add a snippet to the list", preferredStyle: .alert)

        // Add text field to alert controller
            alert.addTextField { (tfName) in
            self.tfName = tfName
            self.tfName.autocapitalizationType = .words
            self.tfName.placeholder = "ex: Meu Snippet"
        }
        
        // Add cancel button to alert controller
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // "Add" button with callback
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            if let name = self.tfName.text, name != "" {
                self.snippets.append(contentsOf: [Snippet(tag: selectedTag), name: self.tfName.text ?? "Novo Snippet", content: "let a = "\(snippets.count)"))])
                self.tableView.reloadData()
            }
        }))

        present(alert, animated: true, completion: nil)
        */
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int {
        return snippets.filter{ $0.tag.title == selectedTag.title} .count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = snippets.filter{ $0.tag.title == selectedTag.title}[indexPath.row].name

        return cell
        
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        let selectedSnippet = snippets[indexPath.row]
        delegate?.snippetSelected(selectedSnippet)

        if let detailViewController = delegate as? DetailViewController {
            splitViewController?.show(detailViewController, sender: nil)
        }
    }
}
    extension MasterTableViewController: TagSelectionDelegate {
        func tagSelected(_ tag: Tag) {
            self.selectedTag = tag
            tableView.reloadData()
        }
    }


