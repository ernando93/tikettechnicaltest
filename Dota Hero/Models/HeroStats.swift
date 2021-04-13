//
//  HeroStats.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import Foundation

public struct HeroStats: Codable {
    let id: Int
    let name, localizedName, primaryAttr, attackType: String
    let roles: [String]
    let img, icon: String
    let baseHealth: Int
    let baseAttackMax, baseStr, baseAgi: Int
    let baseInt: Int
    let moveSpeed: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles = "roles"
        case img = "img"
        case icon = "icon"
        case baseHealth = "base_health"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case moveSpeed = "move_speed"
        }
    
    init(id: Int, name: String, localizedName: String, primaryAttr: String, attackType: String, roles: [String], img: String, icon: String, baseHealth: Int, baseAttackMax: Int, baseStr: Int, baseAgi: Int, baseInt: Int, strGain: Double, agiGain: Double, intGain: Double, attackRange: Int, projectileSpeed: Int, attackRate: Double, moveSpeed: Int, legs: Int) {
        self.id = id
        self.name = name
        self.localizedName = localizedName
        self.primaryAttr = primaryAttr
        self.attackType = attackType
        self.roles = roles
        self.img = img
        self.icon = icon
        self.baseHealth = baseHealth
        self.baseAttackMax = baseAttackMax
        self.baseStr = baseStr
        self.baseAgi = baseAgi
        self.baseInt = baseInt
        self.moveSpeed = moveSpeed
    }
}
