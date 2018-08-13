//
//  ViewController.swift
//  PhoneText
//
//  Created by Neeraj on 8/13/18.
//  Copyright © 2018 Rapidsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

extension ViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        if let text = textField.text {
            let newLength = text.count + string.count - range.length
            let newText = text + string

            if string == ""
            {
                return true
            }

            let textFieldText: NSString = (textField.text ?? "") as NSString
            let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
            if(newLength <= 15){

                let addSpaceLength:Int = (txtAfterUpdate.applyPatternOnNumbers().count - (textField.text?.count)!)
                var selectedText:String = textField.text(in: textField.selectedTextRange!)!
                var extraSpace = ""

                if addSpaceLength > 0
                {
                for i in 1...addSpaceLength
                {
                    extraSpace = "\(extraSpace) "
                }
            }
                else
                {
                    selectedText = ""
                }
                selectedText = "\(selectedText)\(extraSpace)"
                textField.replace(textField.selectedTextRange!, withText: selectedText)

                let newPosition = textField.selectedTextRange
                textField.text = txtAfterUpdate.applyPatternOnNumbers()
                textField.selectedTextRange = newPosition
                return false
            }
            return newLength <= 15
        }
        return true
    }


}

extension String
{
    func applyPatternOnNumbers(pattern: String = "(###) ### ## ##", replacmentCharacter: Character = "#") -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(encodedOffset: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
