//
//  LoginViewController.swift
//  demoApp
//
//  Created by ATPL on 8/1/16.
//  Copyright © 2016 ATPL. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resignKeyBoard(sender: AnyObject)
    {
        sender.resignFirstResponder()
    }
    
    @IBAction func btnLogin(sender: AnyObject)
    {
        if isValidEmail(self.txtEmail.text!) == false
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter valid email.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                alert.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if txtEmail.text!.isEmpty || txtPassword.text!.isEmpty
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter email or password to login.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                alert.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)

        }
        else
        {
            print("email is valid")
            LoginWithEmailOrPass(self.txtEmail.text!, pass: self.txtPassword.text!)
        }
        
    }
    //MARK: validate email
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    // MARK: Login With email or Password
    func LoginWithEmailOrPass(email: String, pass: String) -> Void
    {
        
        self.indicator.hidden = false
        self.indicator.startAnimating()
        let request = NSMutableURLRequest(URL: NSURL(string:"http://resttest.mockable.io/api/session?")!)
         _ = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        let boundary = NSString(format: "---------------------------14737809831466499882746641449")
        let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
        request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        let body = NSMutableData()
        // email
        body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"email\"\r\n\r\n%@",email).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        // password
        body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"password\"\r\n\r\n%@",pass).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        request.HTTPBody = body
        let returnData = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
        if (returnData != nil)
        {
            print(returnData)
            do
            {
                let  dicti = try NSJSONSerialization.JSONObjectWithData(returnData!, options: []) as! NSDictionary
                print(dicti)
                print(dicti .valueForKey("token"))
               // getting token
                let token = dicti.valueForKey("token") as! String
                if token.isEmpty
                {
                    self.indicator.stopAnimating()
                    print("Login failed")
                    let alert = UIAlertController(title: "Alert", message: "Failed to login", preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        alert.dismissViewControllerAnimated(true, completion: nil)
                    }
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                else
                {
                    self.indicator.stopAnimating()
                    print("login success")
                    NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    let controller = self.storyboard?.instantiateViewControllerWithIdentifier("tabbar") as! TabBarViewController
                    self.navigationController?.pushViewController(controller, animated: true)
                    
                }
                
            } catch let err as NSError {
                self.indicator.stopAnimating()
                let alert = UIAlertController(title: "Alert", message: "Please check your internet connection.", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)

                
            }
            
            
        }
        else
        {
            self.indicator.stopAnimating()
        }
    }
   
    
}
