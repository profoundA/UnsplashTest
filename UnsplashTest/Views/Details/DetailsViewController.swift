//
//  DetailsViewController.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var photo: Photo?
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var downloadsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить в избранное", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        favoritesButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
    }
    
    @objc private func addToFavorites() {
        let alertController = UIAlertController(title: "Добавить фото в избранное?", message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            
            let tabBarController = self.tabBarController as! TabBarController
            let navigationController = tabBarController.viewControllers?[1] as! UINavigationController
            let favoritesVC = navigationController.topViewController as! FavoritesViewController
        
            favoritesVC.favoritePhotos.append(self.photo!)
            favoritesVC.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
}

// MARK: setup views
private extension DetailsViewController {
    private func setupViews() {
        navigationItem.title = "Детали"
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(authorLabel)
        view.addSubview(createdLabel)
        view.addSubview(locationLabel)
        view.addSubview(downloadsLabel)
        view.addSubview(favoritesButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            authorLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10),
            
            createdLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            createdLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10),
            
            locationLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 10),
            locationLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10),
            
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            downloadsLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10),
            
            favoritesButton.topAnchor.constraint(equalTo: downloadsLabel.bottomAnchor, constant: 10),
            favoritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoritesButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            favoritesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


