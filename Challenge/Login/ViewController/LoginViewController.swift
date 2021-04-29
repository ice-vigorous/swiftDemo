//
//  LoginViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/19.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import MBProgressHUD
class LoginViewController: UIBaseViewController {
    @IBOutlet weak var closeView: UIImageView!
    @IBOutlet weak var telNum: UITextField!
    @IBOutlet weak var verCode: UITextField!
    @IBOutlet weak var warnningLabel: UILabel!
    @IBOutlet weak var selectView: UIImageView!
    @IBOutlet weak var sendMessageLabel: UILabel!
    let loginVM = LoginVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        closeView.addGestureRecognizer(tapClose)
        
        let tapSendMessage = UITapGestureRecognizer(target: self, action: #selector(sendMessageTap(_:)))
        sendMessageLabel.addGestureRecognizer(tapSendMessage)
    }
    
    @objc func closeTap(_ tap:UITapGestureRecognizer) {
        self.dismiss(animated: true) {
        }
    }

    
    @objc func sendMessageTap(_ tap:UITapGestureRecognizer) {
        self.view.endEditing(true)
        if TelNumberTool().isTelNumber(num: telNum.text! as NSString) {
            //是手机号
            loginVM.sendMessage(telNum: telNum.text!).subscribe(onNext: { (str) in
                
                //开始倒计时
            }, onError: { (error) in

            }, onCompleted: {

            }) {

            }
            
        } else {
            //不是手机号
            MBProgressHUD.showToast("手机号错误，请重新填写")
        }
        
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
