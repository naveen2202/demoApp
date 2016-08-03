//
//  MessageViewController.swift
//  demoApp
//
//  Created by ATPL on 8/2/16.
//  Copyright © 2016 ATPL. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    @IBOutlet weak var mssageTableView: UITableView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    var token = String()
    var allmessages = NSMutableArray()
    var allNames = NSMutableArray()
    var getid = NSString()
    var allides = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = "Chat"
        token = NSUserDefaults.standardUserDefaults().valueForKey("token") as! String
        self.fetchAllMessages()
        self.btnSend.alpha = 0.5
        self.btnSend.enabled = false
        mssageTableView.rowHeight = UITableViewAutomaticDimension
        mssageTableView.estimatedRowHeight = 140
        
        self.btnSend.layer.cornerRadius = 5.0
        self.btnSend.layer.masksToBounds = true
       // self.launchChatController();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: table View methods (delegate or datasource)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.allmessages.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let senderCellID = "sender"
        //let recieverCellID = "reciever"
        //let recieverCell = tableView.dequeueReusableCellWithIdentifier(recieverCellID) as! RecieverCell
        let senderCell = tableView.dequeueReusableCellWithIdentifier(senderCellID) as! SenderCell
        
        //let newid = self.allides.objectAtIndex(indexPath.row) as! NSString
        let textMarginHorizontal: CGFloat = 20
        let heightMargian: CGFloat = 20
//        if newid.isEqualToString("1")
//        {
//            
//            recieverCell.message.layer.cornerRadius = 5.0
//            recieverCell.message.layer.masksToBounds = true
//            
//            recieverCell.name?.text = "Harry"
//            recieverCell.message?.text = self.allmessages.objectAtIndex(indexPath.row) as? String
//            
//            let sizeOfMessage: CGSize = getSizeOfMessage(recieverCell.message.text!)
//            
//           recieverCell.message.frame = CGRectMake(recieverCell.bubble.frame.size.width - sizeOfMessage.width + 55, recieverCell.message.frame.origin.y, sizeOfMessage.width, sizeOfMessage.height)
//            
//            
//            let rightImage = UIImage(named: "chat.icon1.png")?.stretchableImageWithLeftCapWidth(21, topCapHeight: 18)
//            recieverCell.bubble.image = rightImage
//            
//            recieverCell.bubble.frame = CGRectMake(recieverCell.bubble.frame.size.width - sizeOfMessage.width + 50, recieverCell.bubble.frame.origin.y, sizeOfMessage.width + textMarginHorizontal, sizeOfMessage.height + heightMargian)
//
//
//
//            return recieverCell
//        }
//        else
//        {
        
            senderCell.senderMessage.layer.cornerRadius = 5.0
            senderCell.senderMessage.layer.masksToBounds = true
        
            senderCell.senderMessage?.text = self.allmessages.objectAtIndex(indexPath.row) as? String
            senderCell.senderName?.text = self.allNames.objectAtIndex(indexPath.row) as? String
            //let sizeOfMessage: CGSize = getSizeOfMessage(senderCell.senderMessage.text!)
            //senderCell.senderMessage.frame = CGRectMake(35 + 5, senderCell.senderMessage.frame.origin.y, sizeOfMessage.width, sizeOfMessage.height)
//
//            
//            let leftImage = UIImage(named: "chat-icon2.png")?.stretchableImageWithLeftCapWidth(21, topCapHeight: 18)
//            senderCell.bubble.image = leftImage
//            
//            senderCell.bubble.frame = CGRectMake(20 + 5, senderCell.bubble.frame.origin.y, sizeOfMessage.width + textMarginHorizontal, sizeOfMessage.height + heightMargian)
//            
//            senderCell.senderMessage.textAlignment = .Justified
//
//            
        
            
            return senderCell
            
        //}
     }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // Mark: UITextField Delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count > 1
        {
            self.btnSend.enabled = false
            self.btnSend.alpha = 0.5
            return true
        }
        else
        {
            self.btnSend.enabled = true
            self.btnSend.alpha = 1.0
        }
        return true
    }
    
    //MARK: Send message 
    @IBAction func sendButton(sender: AnyObject) {
        if self.txtMessage.text!.isEmpty
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please type a message to send.", preferredStyle: .Alert)
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
            let request = NSMutableURLRequest(URL: NSURL(string:"http://resttest.mockable.io/api/message")!)
            
            request.HTTPMethod = "POST"
            let boundary = NSString(format: "---------------------------14737809831466499882746641449")
            let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
            
            request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
            request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "X-Token")
            let body = NSMutableData()
            
            //
            body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"message\"\r\n\r\n%@",self.txtMessage.text!).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            
            
            request.HTTPBody = body
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request)
                {
                    (let data: NSData? ,let response: NSURLResponse?, let error: NSError?) -> Void in
                    let httpResponse = response as! NSHTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    if (statusCode == 200)
                    {
                        do {
                            let anyObj = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                            print(anyObj)
                            
                            dispatch_async(dispatch_get_main_queue())
                                {
                                    if NSThread.mainThread().isMainThread
                                    {
                                        let mess = anyObj.valueForKey("message") as! String
                                        let name = anyObj.valueForKey("name") as! String
                                        if mess.isEmpty
                                        {
                                            
                                        }
                                        else
                                        {
                                            self.getid = "one"
                                            //let combinemes = "This is testing autolayout message for demo app \n and created by atpo " + mess
                                            self.allNames.addObject(name)
                                            self.allmessages.addObject(mess)
                                            self.mssageTableView.reloadData()
                                            self.txtMessage.text = ""
                                            //self.fetchAllMessages()
                                            
                                            
                                            
                                            
                                        }
                                    }
                            }
                        } catch let error as NSError {
                            
                            let alert = UIAlertController(title: "Error", message: "Please check your internet connection.", preferredStyle: .Alert)
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
                        
                    }
                    print("Everyone is fine, file downloaded successfully.")
                    
            }
            task.resume()



                    }
    }
     // MARK: Fetch ALL Messages
    //http://resttest.mockable.io/api/message
    func fetchAllMessages() -> Void
    {
        let Requestdetails = String(format: "http://resttest.mockable.io/api/message")
        print(Requestdetails)
        let requesturl: NSURL = NSURL(string: Requestdetails)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: requesturl)
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "X-Token")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request)
            {
                (let data: NSData? ,let response: NSURLResponse?, let error: NSError?) -> Void in
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode = httpResponse.statusCode
                if (statusCode == 200)
                {
                    do {
                        let anyObj = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSArray
                        print(anyObj)
                        
                        //let respArr = anyObj.valueForKey("response") as! NSArray
                        dispatch_async(dispatch_get_main_queue())
                            {
                                if NSThread.mainThread().isMainThread
                                {
                                    for var i = 0; i < anyObj.count; i++
                                    {
                                        
                                        let mes = anyObj.valueForKey("message").objectAtIndex(i)
                                        let name = anyObj.valueForKey("name").objectAtIndex(i)
                                        self.allNames.addObject(name)
                                        self.allmessages.addObject(mes)
                                        
                                        print(name)
                                        print(mes)
                                    }
                                    self.mssageTableView.reloadData()
                                }
                        }
                        
                        
                    } catch let error as NSError {
                        print("json error: \(error.localizedDescription)")
                        let alert = UIAlertController(title: "Error", message: "Please check your internet connection.", preferredStyle: .Alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            alert.dismissViewControllerAnimated(true, completion: nil)
                        }
                        alert.addAction(okAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
                print("Everyone is fine, file downloaded successfully.")
                
        }
        task.resume()


    }
    func getSizeOfMessage(message: NSString) -> CGSize
    {
        let gettingSizelabel = UILabel()
        gettingSizelabel.font = UIFont.systemFontOfSize(14)
        gettingSizelabel.text = message as String
        gettingSizelabel.numberOfLines = 0
        let maximumLabelSize: CGSize = CGSizeMake(200, 9999)
        
        let expectedSize = gettingSizelabel.sizeThatFits(maximumLabelSize)
        
        return expectedSize
    }
    
    
}
/*
let request = NSMutableURLRequest(URL: NSURL(string:"http://resttest.mockable.io/api/message")!)

request.HTTPMethod = "POST"
let boundary = NSString(format: "---------------------------14737809831466499882746641449")
let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)

request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
request.setValue(token, forHTTPHeaderField: "X-Token")
let body = NSMutableData()

//
body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
body.appendData(NSString(format:"Content-Disposition: form-data; name=\"message\"\r\n\r\n%@",self.txtMessage.text!).dataUsingEncoding(NSUTF8StringEncoding)!)
body.appendData(NSString(format:"\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)


request.HTTPBody = body
let session = NSURLSession.sharedSession()

let task = session.dataTaskWithRequest(request)
{
(let data: NSData? ,let response: NSURLResponse?, let error: NSError?) -> Void in
let httpResponse = response as! NSHTTPURLResponse
let statusCode = httpResponse.statusCode
if (statusCode == 200)
{
do {
let anyObj = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
print(anyObj)

dispatch_async(dispatch_get_main_queue())
{
if NSThread.mainThread().isMainThread
{
let mess = anyObj.valueForKey("message") as! String
let name = anyObj.valueForKey("name") as! String
if mess.isEmpty
{

}
else
{
self.getid = "one"
//let combinemes = "This is testing autolayout message for demo app \n and created by atpo " + mess
self.allNames.addObject(name)
self.allmessages.addObject(mess)
self.mssageTableView.reloadData()
self.txtMessage.text = ""
//self.fetchAllMessages()




}
}
}
} catch let error as NSError {

let alert = UIAlertController(title: "Error", message: "Please check your internet connection.", preferredStyle: .Alert)
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

}
print("Everyone is fine, file downloaded successfully.")

}
task.resume()

*/

