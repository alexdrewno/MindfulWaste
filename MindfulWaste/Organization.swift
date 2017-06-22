import UIKit

class Organization: NSObject
{
    var creator = ""
    var dateCreated = ""
    var orgName = ""
    var numReports = 0
    var description2 = ""
    var usersInOrganization = [String]()
    
    init(c: String, dc: String, name: String, d: String)
    {
        creator = c
        dateCreated = dc
        orgName = name
        description2 = d
    }
    
    func toAnyObject() -> Any
    {
        return [
            "orgName": orgName,
            "description": description2,
            "dateCreated": dateCreated,
            "creator": creator,
            "numReports": numReports,
            "usersInOrganization": usersInOrganization
        ]
    }
}
