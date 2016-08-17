//
//  wizard.swift
//  oop-rpg
//
//  Created by Sergei Stanislauchyk on 02.07.16.
//  Copyright © 2016 Rub of the Green. All rights reserved.
//

import Foundation

class Witch: Enemy {
    override var loot: [String] {
        return ["Magic Wand","Dark Amulet","Salted Pork"]
    }
    
    override var type: String {
        return "Witch"
    }
}