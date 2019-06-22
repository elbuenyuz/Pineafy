import UIKit

class DailyInsightCell: BaseCell, UITextViewDelegate, UITextFieldDelegate{
//    Mark: ~ objects
    
    var dInsight: DailyInsight? {
        didSet{
            guard let unwrappedInsight = dInsight else {return}
            imageBg.image = unwrappedInsight.img
         
            
            let attributeText = NSMutableAttributedString(string: unwrappedInsight.name, attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Bold", size: 15)])
            
            descriptionTextView.text = unwrappedInsight.title
            //second Text
            attributeText.append(NSMutableAttributedString(string: "\n\(unwrappedInsight.title)", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-LightItalic", size: 12)]))
            
            
            descriptionTextView.attributedText = attributeText
            descriptionTextView.textAlignment = .center
            
        }
    }
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let imgProfile: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "provider")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "Title"
        textView.font = UIFont.italicSystemFont(ofSize: 11)
    
        textView.addShadow()
        textView.isScrollEnabled = false
//        textView.backgroundColor = .yellow
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let imageBg: UIImageView = {
        var image = UIImageView()
        image.image = #imageLiteral(resourceName: "insight-200x300")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
        image.addShadowIcon()
//        image.backgroundColor = .green
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupItemCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItemCell(){
        
        addSubview(imageBg)
        imageBg.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        imageBg.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageBg.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageBg.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: imageBg.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

    }
}


