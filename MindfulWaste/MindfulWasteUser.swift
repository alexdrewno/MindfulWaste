import UIKit

class MindfulWasteUser : NSObject
{
//    fileprivate var emailField: ErrorTextField!
//    fileprivate var passwordField: TextField!
//    fileprivate var confirmPasswordField : ErrorTextField!
//    fileprivate var firstNameField: TextField!
//    fileprivate var lastNameField : TextField!
//    var gender = ""
    
    var email = ""
    var firstName = ""
    var lastName = ""
    var gender = ""
    var organizations = [""]
    
    
    init(email: String, firstName: String, lastName: String, gender: String, organization: [String]? = nil)
    {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        if organization != nil
        {
            self.organizations = organization!
        }
    }
    
    func toAnyObject() -> Any
    {
        return [
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "gender": gender,
            "organization" : organizations
        ]
        
    }

    
    
}
