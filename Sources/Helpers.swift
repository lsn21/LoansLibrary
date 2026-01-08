//
//  Helpers.swift
//  Helpers
//
//  Created by Siarhei Lukyanau on 31.10.25.
//

import Foundation
import UIKit

public class Helpers {
    static var textFields = [UITextField?]()
    static var textField = UITextField()
    static var textViews = [UITextView?]()
    static var textView = UITextView()
    
    public class func random(_ divValue: Int, addValue: Int = 0) -> Int {
        var randomValue = Int(DispatchTime.now().rawValue) % divValue
        randomValue += addValue
        return randomValue
    }

    public class func isPhone() -> Bool {
        let model = UIDevice().model
        if model == "iPhone" {
            return true
        }
        return false
    }
    
    public class func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        formatter.locale = Locale.current
        let returnStr = formatter.string(from: NSNumber(value: number)) ?? "\(number)"
        return returnStr
    }
    
    public class func checkURLAvailability(urlString: String, completion: @escaping (_ success: Bool, _ statusCode: Int) -> Void) {
        var varUR: URL
         guard let url = URL(string: urlString) else {
            print("Неверный URL")
            completion(false, -98)
            return
        }
        varUR = url
        var request = URLRequest(url: varUR)
        request.httpMethod = "HEAD"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Ошибка при доступе к URL: \(error.localizedDescription)")
                completion(false, -99)

                return
            }
            else if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode == 200 {
                   completion(true, statusCode)
                }
                else {
                    print("URL не доступен, статус код: \(httpResponse.statusCode)")
                    completion(false, statusCode)
                }
            }
        }
        task.resume()
    }
    
    public class func getToolbar(navItem: UINavigationItem, textField: UITextField) -> UIToolbar {
        
        self.textField = textField
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        toolbar.barTintColor = UIColor(red: 195.0/255.0, green: 195.0/255.0, blue: 195.0/255.0, alpha: 0.5)
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeKeyboardTextField)
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, closeButton]
        
        return toolbar
    }
    
    @objc class func closeKeyboardTextField() {
        textField.resignFirstResponder()
    }

    public class func getToolbar(navItem: UINavigationItem, textFields: [UITextField?]) -> UIToolbar {
        
        self.textFields = textFields
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        toolbar.barTintColor = UIColor(red: 195.0/255.0, green: 195.0/255.0, blue: 195.0/255.0, alpha: 0.5)
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeKeyboardTextFields)
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, closeButton]
        
        return toolbar
    }
    
    @objc class func closeKeyboardTextFields() {
        textFields.forEach { field in
            field?.resignFirstResponder()
        }
    }
    
    public class func getToolbarTextView(navItem: UINavigationItem, textView: UITextView) -> UIToolbar {
        
        self.textView = textView
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let tintColor = UIColor(red: 195.0/255.0, green: 195.0/255.0, blue: 195.0/255.0, alpha: 0.5)
        toolbar.barTintColor = tintColor
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeKeyboardTextView)
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, closeButton]
        return toolbar
    }
 
    @objc class func closeKeyboardTextView() {
        textView.resignFirstResponder()
    }

    public class func getToolbarTextView(navItem: UINavigationItem, textViews: [UITextView?]) -> UIToolbar {

        self.textViews = textViews
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        toolbar.barTintColor = UIColor(red: 195.0/255.0, green: 195.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeKeyboardTextViews)
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, closeButton]
        return toolbar
    }

    @objc class private func closeKeyboardTextViews() {
        textViews.forEach { textView in
            textView?.resignFirstResponder()
        }
    }
}
