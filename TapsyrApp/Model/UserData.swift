//
//  UserData.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

struct UserData: Codable {
    let id: Int?
    let email: String?
    let phone: String?
    let role: String?
    let confirmed: Int?
    let rating: Int?
    let name: String?
    let avatar: String?
    let about: String?
    let state: String?
    let city: String?
    let facebook: String?
    let instagram: String?
    let twitter: String?
    let skype: String?
    let contactPhone: String?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case phone
        case role
        case confirmed
        case rating
        case name
        case avatar
        case about
        case state
        case city
        case facebook
        case instagram
        case twitter
        case skype
        case contactPhone = "contact_phone"
    }
    
    func getProfileData() -> [(String, String)] {
        
        var titles = [String]()
        var values = [String]()
        
        if let email = self.email { titles.append("Email"); values.append(email) }
        if let phone = self.phone { titles.append("Phone"); values.append(phone) }
        if let role = self.role { titles.append("Role"); values.append(role) }
        if let rating = self.rating { titles.append("Rating"); values.append("\(rating)") }
        if let name = self.name { titles.append("Name"); values.append(name) }
        if let avatar = self.avatar { titles.append("Avatar (URL)"); values.append(avatar)}
        if let about = self.about { titles.append("About"); values.append(about) }
        if let state = self.state { titles.append("State"); values.append(state) }
        if let city = self.city { titles.append("City"); values.append(city) }
        if let facebook = self.facebook { titles.append("Facebook"); values.append(facebook) }
        if let instagram = self.instagram { titles.append("Instagram"); values.append(instagram) }
        if let twitter = self.twitter { titles.append("Twitter"); values.append(twitter) }
        if let skype = self.skype { titles.append("Skype"); values.append(skype) }
        if let contactPhone = self.contactPhone { titles.append("Contact phone"); values.append(contactPhone) }
        
        return Array(zip(titles, values))
    }
}
