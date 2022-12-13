import UIKit


func asyncLoadImage(_ imageView: UIImageView, urlString: String, size: CGSize) {
    DispatchQueue.global(qos: .userInitiated).async {
        let image = resizeImage(at: urlString, for: size)
        
        DispatchQueue.main.sync {
            UIView.transition(with: imageView,
                              duration: 1.0,
                              options: [.curveEaseOut, .transitionCrossDissolve],
                              animations: {
                                imageView.image = image
                            })

        }
    }
}

    //the method redraws the image to the specified dimensions
func resizeImage(at urlString: String, for size: CGSize) -> UIImage? {
    let file = urlString.removingPercentEncoding ?? Constants.Default.badConnection
    
    guard let url = URL(string: file),
          let data = try? Data(contentsOf: url)
    else {
        print("Problemss")
        return UIImage()
    }
    let image = UIImage(data: data) ?? UIImage()

    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
    }
}
