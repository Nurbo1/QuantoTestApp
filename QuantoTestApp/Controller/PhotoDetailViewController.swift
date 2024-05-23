//
//  PhotoDetailViewController.swift
//  QuantoTestApp
//
//  Created by Нурбол Мухаметжан on 25.05.2024.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayouts()
        

        if let photo = photo{
            DispatchQueue.global().async {
                self.fetchingPhoto(with: photo)
            }
        }
    }
    
    
    // MARK: - UI Components
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Layout setups and functions
    func fetchingPhoto(with photo: Photo){
        
        if let url = URL(string: photo.url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("ERROR in data fetching in detailVC")
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    self.titleLabel.text = "\(photo.id). \(photo.title.prefix(1).capitalized)\(photo.title.suffix(photo.title.count-1).lowercased())"
                }
            }.resume()
        }
    }
    
    private func formatTitle(_ title: String) -> String {
        let formattedTitle = title.prefix(1).capitalized + title.dropFirst().lowercased()
        return "\(photo?.id ?? 0). \(formattedTitle)"
    }
    
    func setupViews() {
        view.addSubview(imageView)
        imageView.addSubview(titleLabel)
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -15),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10)
        ])
    }
}
