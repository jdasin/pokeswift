//
//  ViewController.swift
//  pokedex
//
//  Created by Admin on 4/5/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let manager = PokemonManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        manager.delegate = self
        manager.fetchPokemon()
    }

    

}
extension ViewController: PokemonManagerDelegate {
    func onFetchSuccess(result: [Pokemon]?) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onError(error: Error) {
        print(error)
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "pokeCell")
        let poke = manager.pokemonList[indexPath.row]
        cell.textLabel?.text = poke.name! + " " + (String(poke.id!))
        if let imageUrl = poke.imageUrl {
            cell.imageView?.load(url: imageUrl, onLoad: {
                [weak cell] image in cell?.setNeedsLayout()
            })
        }
        return cell
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        manager.pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: "pokeCell",
              for: indexPath)
            cell.backgroundColor = .black
            // Configure the cell
            return cell
    }
    
    
}

