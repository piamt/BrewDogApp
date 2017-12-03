//
//  BeerCell.swift
//  BrewDogApp
//
//  Created by Pia on 28/11/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit
import Cartography
import SDWebImage

class BeerCell: UICollectionViewCell {
    
    //MARK: - Stored properties
    let imageLabels: ImageLabelsView = ImageLabelsView()
    let descriptionLabel: UILabel = UILabel.BrewDogLabel
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Style.ListTypes.collectionCellColor
        
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private API
    private func layout() {
        descriptionLabel.font = UIFont.brandFont()
        descriptionLabel.sizeToFit()
        
        self.addSubview(imageLabels)
        self.addSubview(descriptionLabel)
        
        constrain(imageLabels, descriptionLabel) { imageLabels, description in
            let parent = imageLabels.superview!
            
            imageLabels.top == parent.top + 10
            imageLabels.leading == parent.leading + 10
            imageLabels.centerX == parent.centerX
            imageLabels.height == parent.height * 0.6
            
            description.top == imageLabels.bottom + 10
            description.leading == parent.leading + 10
            description.centerX == parent.centerX
        }
    }
    
    //MARK: - Public API
    public func configure(model: BeerViewModel) {
        
        //Stack
        imageLabels.configure(model: model)
        
        //Labels text
        descriptionLabel.text = "\(model.description)"
    }
}

class LabelsStack: UIStackView {
    
    //MARK: - Stored properties
    let nameLabel: UILabel = UILabel.BrewDogLabel
    let taglineLabel: UILabel = UILabel.BrewDogLabel
    let abvLabel: UILabel = UILabel.BrewDogLabel
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        axis = .vertical
        spacing = 5.0
        alignment = .center
        distribution = .fill
        
        nameLabel.font = UIFont.brandTitleFont()
        nameLabel.sizeToFit()
        taglineLabel.sizeToFit()
        abvLabel.sizeToFit()
        
        self.addArrangedSubview(nameLabel)
        self.addArrangedSubview(taglineLabel)
        self.addArrangedSubview(abvLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public API
    public func configure(model: BeerViewModel) {
        //Labels text
        nameLabel.text = "\(model.name)"
        taglineLabel.text = "\(model.tagline)"
        abvLabel.text = "\(model.abv)%"
    }
}

class ImageLabelsView: UIView {
    
    //MARK: - Stored properties
    var imageView: UIImageView
    let stackLabels: LabelsStack = LabelsStack(frame: .zero)
    
    override init(frame: CGRect) {
        
        imageView = {
            let imageView: UIImageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(stackLabels)
        
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private API
    private func layout() {
        constrain(imageView, stackLabels) { image, stack in
            let parent = image.superview!
            
            image.leading == parent.leading
            image.centerY == parent.centerY
            image.height == parent.height * 0.7
            image.width == parent.width * 0.4
            
            stack.trailing == parent.trailing
            stack.centerY == image.centerY
            stack.leading == image.trailing
        }
    }
    
    //MARK: - Public API
    public func configure(model: BeerViewModel) {
        //Image
        imageView.sd_setImage(with:  URL(string: model.image_url),
                              placeholderImage: nil,
                              options: SDWebImageOptions.retryFailed,
                              completed: nil)
        
        //Stack labels
        stackLabels.configure(model: model)
    }
}
