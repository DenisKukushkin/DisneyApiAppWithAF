//
//  HeroListTableViewController.swift
//  DisneyApiAppWithAF
//
//  Created by Denis Kukushkin on 08.12.2022.
//

import UIKit


class HeroListTableViewController: UITableViewController {

    @IBAction func upadtaData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: disney?.nextPage ?? "")
        : fetchData(from: disney?.previousPage ?? "")
        
    }
    
    private var disney: Disney?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = .white
        
        fetchData(from: Link.disneyAPI.rawValue)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        disney?.data?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let disneyHero = disney?.data?[indexPath.row]
        cell.configure(with: disneyHero)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let detailsVC = segue.destination as? HeroDetailsViewController else { return }
        detailsVC.disneyHero = disney?.data?[indexPath.row]
        
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let disney):
                self.disney = disney
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

