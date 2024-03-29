//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by o.yuki on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    var questions: [[String: Any]] = []
//    let questions: [[String: Any]] = [
//        [
//            "question": "iPhoneアプリを開発する統合環境はZcodeである",
//            "answer": false
//        ],
//        [
//            "question": "Xcode画面の右側にはユーティリティーズがある",
//            "answer": true
//        ],
//        [
//            "question": "UILabelは文字列を表示する際に利用する",
//            "answer": true
//        ]
//    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil{
            questions = userDefaults.object(forKey: "add") as! [[String: Any]]
        }
        showQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil{
            questions = userDefaults.object(forKey: "add") as! [[String: Any]]
        }
        showQuestion()
    }
    
    func showQuestion() {
        if questions.isEmpty == true {
            questionLabel.text = "問題がありません、問題を作りましょう！"
        } else {
            let question = questions[currentQuestionNum]
            
            if let que = question["question"] as? String {
                questionLabel.text = que
            }
        }
    }
    
    func checkAnswer(yourAnswer: Bool) {
        if questions.isEmpty == true {
            
        } else {
            let question = questions[currentQuestionNum]
            
            if let ans = question["answer"] as? Bool {
                if yourAnswer == ans {
                    currentQuestionNum += 1
                    showAlert(message: "正解！")
                } else {
                    showAlert(message: "不正解…")
                }
            } else {
                print("答えが入ってません")
                return
            }
            
            if currentQuestionNum >= questions.count {
                currentQuestionNum = 0
            }
            
            showQuestion()            
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
}

