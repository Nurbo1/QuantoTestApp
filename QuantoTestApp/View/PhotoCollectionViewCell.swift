//
//  PhotoCollectionViewCell.swift
//  QuantoTestApp
//
//  Created by Нурбол Мухаметжан on 23.05.2024.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - functions
    
    
    func setupCell(with photo: Photo) {
        self.titleLabel.text = formatTitle(photo.title)
        if let url = URL(string: photo.thumbnailUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.titleLabel.text = nil
    }
    
    
    // MARK: - UI Items
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // MARK: - Setup views and layouts
    
    private func formatTitle(_ title: String) -> String {
        let formattedTitle = title.prefix(1).capitalized + title.dropFirst().lowercased()
        return "\(formattedTitle)"
    }
    
    func setupViews(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        contentView.isUserInteractionEnabled = true
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    
    func setupLayouts(){
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/2)
        ])
        
    }
    
}
