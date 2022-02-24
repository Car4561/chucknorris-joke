//
//  ListJokeController.swift
//  project
//
//  Created by carlos alfredo llerena huayta on 23.02.22.
//

import Foundation
import UIKit

protocol ListJokeView: class {
    var viewModel: ListJokeViewModel! {get set}
}

class ListJokeViewController: UIViewController, ListJokeView {

    var presenter: ListJokePresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListJokeViewModel! {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
        setupTableView()
    }
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let listJokeCell = UINib(nibName: "ListJokeCell", bundle: nil)
        tableView.register(listJokeCell, forCellReuseIdentifier: "ListJokeCell")
    }
    
    
}

extension ListJokeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListJokeCell", for: indexPath) as? ListJokeCell else {
            return UITableViewCell()
        }
        
        let cellModel = viewModel.cells[indexPath.row]
        cell.setup(model: cellModel)
        
        return cell
        
    }
    
    
    
}
