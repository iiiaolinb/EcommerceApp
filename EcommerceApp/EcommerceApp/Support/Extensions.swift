import UIKit

extension UIButton {
    convenience init(title: String, target: Any, selector: Selector?) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        guard let selector = selector else { return }
        addTarget(target, action: selector, for: .touchUpInside)
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var myHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        myHex = myHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        
        guard Scanner(string: myHex).scanHexInt64(&rgb) else { return nil}
        r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        b = CGFloat(rgb & 0x00FF) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension UIViewController {
    func reloadView() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
}
