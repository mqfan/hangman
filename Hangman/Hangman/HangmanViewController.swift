//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    var hangmanPhrases = HangmanPhrases()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate a random phrase for the user to guess\
        
        hangmanPhrases.initAnswerAndValidLetters()
        updateDisplayedGuesses()
        print(hangmanPhrases.answer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var hangmanImage: UIImageView!
    func updateHangmanImage() {
        let numWrong = hangmanPhrases.incorrectGuesses.count
        if numWrong == 0 {
            hangmanImage.image = UIImage(named: "hangman1")
        } else if (numWrong <= 6){
            let imgName: String = "hangman" + String(numWrong + 1)
            hangmanImage.image = UIImage(named: imgName)
        }
    }
    
    
    @IBOutlet weak var incorrectLetters: UILabel!
    func updateIncorrectLetters() {
        var incorrectList = ""
        for c in hangmanPhrases.incorrectGuesses {
            incorrectList += String(c) + ", "
        }
        self.incorrectLetters.text = incorrectList
    }
    
    
    @IBOutlet weak var guessedLetter: UITextField!
    
    
    @IBOutlet weak var displayedGuesses: UILabel!
    func updateDisplayedGuesses() {
        displayedGuesses.text = hangmanPhrases.displayedProgress()
    }
    
    
    @IBAction func madeGuess(_ sender: UIButton) {
        var userGuess:String = guessedLetter.text ?? ""
        guessedLetter.text = ""
        if userGuess.characters.count > 1 {
            return
        }
        userGuess = userGuess.capitalized
        let checkLetter: Character = userGuess.characters.first ?? " "
        hangmanPhrases.checkGuess(checkLetter)
        updateIncorrectLetters()
        updateDisplayedGuesses()
        updateHangmanImage()
        if hangmanPhrases.checkWin() {
            endGame(msg: "You won!")
        }
        print("got here")
        if hangmanPhrases.checkLoss() {
            endGame(msg: "Rip you lost")
        }
        
    }
    
    func endGame(msg: String){
        let alertController = UIAlertController(title: msg, message:
            nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default,handler: resetGame))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func resetGame(alert: UIAlertAction!){
        print("Game has been restarted.")
        
        hangmanPhrases = HangmanPhrases()
        hangmanPhrases.initAnswerAndValidLetters()
        
        updateIncorrectLetters()
        updateDisplayedGuesses()
        updateHangmanImage()
    }
    
    
    
    
    
    
}
