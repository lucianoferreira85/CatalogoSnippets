//
//  TagViewController.swift
//  CatalogoSnippets
//
//  Created by Luciano Ferreira on 12/04/21.
//

import UIKit

protocol TagSelectionDelegate: AnyObject {
    func tagSelected(_ tag: Tag)
}
class TagsViewController: UITableViewController {
    weak var delegate: TagSelectionDelegate?
    
    var tags: [Tag] = [
        Tag(title: "Networking"),
        Tag(title: "Persistência"),
        Tag(title: "Variaveis")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        
        cell.textLabel?.text = tags[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTag = tags[indexPath.row]
        delegate?.tagSelected(selectedTag)
    }
}
