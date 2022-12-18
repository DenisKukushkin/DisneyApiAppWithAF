//
//  TableViewCell.swift
//  DisneyApiAppWithAF
//
//  Created by Denis Kukushkin on 08.12.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView! {
        didSet {
            heroImageView.contentMode = .scaleAspectFit
            heroImageView.clipsToBounds = true
            heroImageView.layer.cornerRadius = heroImageView.frame.height / 2
            heroImageView.backgroundColor = .gray
        }
    }
    
    
    func configure(with disneyHero: DisneyHero?) {
        heroNameLabel.text = disneyHero?.name
        guard let imageURL = disneyHero?.imageUrl else { return }
        ImageManager.shared.fetchImage(from: imageURL) { result in
            switch result {
            case .success(let imageData):
                self.heroImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
                
            }
        }
    }
}




