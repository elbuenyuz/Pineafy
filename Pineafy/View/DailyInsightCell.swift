import UIKit

class DailyInsightCell: UICollectionViewCell {
    
    var dInsight: DailyInsight? {
        didSet{
            guard let unwrappedInsight = dInsight else {return}
            imageBg.image = unwrappedInsight.img
        }
    }
    
    let imageBg: UIImageView = {
        var image = UIImageView()
        image.image = #imageLiteral(resourceName: "insight-200x300")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        layer.cornerRadius = 5
        clipsToBounds = true
        setupItemCell()
        self.addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItemCell(){
        addSubview(imageBg)
        
        imageBg.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageBg.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageBg.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageBg.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}



extension UICollectionViewCell {
    func addShadow(){
        let graySahdow = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0).cgColor
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = graySahdow
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 2.5
    }
}
