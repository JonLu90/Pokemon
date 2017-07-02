
import UIKit

class Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(pokemonData: Pokemon) {
        // TO DO
    }
    
    func setUI() {
        backgroundColor = UIColor.blue
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(pokemonImageView)
        
        setConstraints()
    }
    
    func setConstraints() {
        pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        pokemonImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: pokemonImageView.rightAnchor, constant: 0).isActive = true
        pokemonImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
}
