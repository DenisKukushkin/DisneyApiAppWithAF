//
//  HeroDetailsViewController.swift
//  DisneyApiAppWithAF
//
//  Created by Denis Kukushkin on 08.12.2022.
//

import UIKit

class HeroDetailsViewController: UIViewController {
    
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.cornerRadius = heroImageView.frame.height / 2
        }
    }
    
    var disneyHero: DisneyHero!
    
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner(in: view)
        heroDescriptionLabel.text = disneyHero.description
        title = disneyHero.name
        heroImageView.backgroundColor = .gray
        DispatchQueue.global().async {

            guard let imageURL = self.disneyHero.imageUrl else { return }
            
            ImageManager.shared.fetchImage(from: imageURL) { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        self.heroImageView.image = UIImage (data: imageData)
                        self.spinnerView.stopAnimating()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        func showSpinner(in view: UIView) {
            spinnerView = UIActivityIndicatorView (style: .large)
            spinnerView.color = .white
            spinnerView.startAnimating()
            spinnerView.center = heroImageView.center
            spinnerView.hidesWhenStopped = true
            
            view.addSubview(spinnerView)
            
        }
        
        

    }
}
