import UIKit

protocol AlertDisplayable {
    var controller: UIAlertController { get }
    @discardableResult func title(_ title: String?) -> Self
    @discardableResult func message(_ message: String?) -> Self
    @discardableResult func action(title: String?, style: UIAlertAction.Style, onSelection: ((UIAlertAction) -> ())?) -> Self
    @discardableResult func withTintColor(_ color: UIColor) -> Self
    func show(on controller: UIViewController?, animated: Bool, onCompletion: CompletionHandler)
}

extension AlertDisplayable {
    
    typealias CompletionHandler = (() -> Void)?
    
    @discardableResult public func title(_ title: String?) -> Self {
        controller.title = title
        return self
    }
    
    @discardableResult public func message(_ message: String?) -> Self {
        controller.message = message
        return self
    }
    
    @discardableResult public func action(title: String?,
                                          style: UIAlertAction.Style,
                                          onSelection: ((UIAlertAction) -> ())? = nil ) -> Self {
        controller.title = title
        controller.addAction(UIAlertAction(title: title, style: style, handler: onSelection))
        return self
    }
    
    @discardableResult public func withTintColor(_ color: UIColor) -> Self {
        controller.view.tintColor = color
        return self
    }
    
    public func show(on controller: UIViewController? = nil, animated: Bool = true, onCompletion: CompletionHandler = nil) {
        guard let vc = controller else { return }
        vc.present(self.controller, animated: animated, completion: onCompletion)
    }
    
}

final class Alert: AlertDisplayable {
    public var controller: UIAlertController
    public init() {
        self.controller = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .alert)
    }
}

final class ActionSheet: AlertDisplayable {
    public var controller: UIAlertController
    public init() {
        self.controller = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
    }
}

