import UIKit

extension UILabel {
    
    func addImageWith(name: String, behindText: Bool) {

         let attachment = NSTextAttachment()
         attachment.image = UIImage(named: name)
         let attachmentString = NSAttributedString(attachment: attachment)

         guard let txt = self.text else {
             return
         }

         if behindText {
             let strLabelText = NSMutableAttributedString(string: txt)
             strLabelText.append(attachmentString)
             self.attributedText = strLabelText
         } else {
             let strLabelText = NSAttributedString(string: txt)
             let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
             mutableAttachmentString.append(strLabelText)
             self.attributedText = mutableAttachmentString
         }
     }
}

