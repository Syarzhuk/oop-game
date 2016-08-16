//
//  ViewController.swift
//  oop-rpg
//
//  Created by Sergei Stanislauchyk on 02.07.16.
//  Copyright © 2016 Rub of the Green. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var playerHpLbl: UILabel!
    
    @IBOutlet weak var enemyHpLbl: UILabel!
    
    @IBOutlet weak var enemyImg: UIImageView!
    
    @IBOutlet weak var chestBtn: UIButton!
    
    // MARK: - Constraints Outlets
    
    @IBOutlet weak var AttackButton: UIButton!
    @IBOutlet weak var width: NSLayoutConstraint!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player = Player (name: "DirtyLaundry21", hp: 110, attackPwr: 20)
        generateRandomEnemy()

        playerHpLbl.text = "\(player.hp) HP"
        enemyHpLbl.text = "\(enemy.hp) HP"
        

        
    }

    private func actWithConstraintsAndChestBtn(state: Bool) {
        if state {
            NSLayoutConstraint.activateConstraints([width, height])
        } else {
            NSLayoutConstraint.deactivateConstraints([width, height])
        }
        chestBtn.hidden = state
    }
    
    func generateRandomEnemy () {
        let rand = Int(arc4random_uniform(2))
        
        if rand == 0 {
            enemy = Kimara(startingHp: 50, attackPwr: 12)
        } else {
            enemy = Wizard(startingHp: 60, attackPwr: 15)
        }

        enemyImg.hidden = false
        AttackButton.enabled = true

    }

    
    @IBAction func onChestTapped(sender: AnyObject) {
        //chestBtn.hidden = true
        actWithConstraintsAndChestBtn(true)
        printLbl.text = chestMessage
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.generateRandomEnemy), userInfo: nil, repeats: false)
    }

    @IBAction func attackTapped(sender: UIButton) {
        if enemy.attemptAttack(player.attackPwr) {
            printLbl.text = "Attacked \(enemy.type) for \(player.attackPwr) HP"
            enemyHpLbl.text = "\(enemy.hp) HP"
        } else {
            printLbl.text = "Attack was unsuccessful!"
        }
        
        if let loot = enemy.dropLoot() {
            player.addItemToInventory(loot)
            chestMessage = "\(player.name) found \(loot)"
            //chestBtn.hidden = false
            actWithConstraintsAndChestBtn(false)
        }
        
        if !enemy.isAlive {
            enemyHpLbl.text = ""
            printLbl.text = "Killed \(enemy.type)"
            enemyImg.hidden = true
            sender.enabled = false
            }
    }


}

