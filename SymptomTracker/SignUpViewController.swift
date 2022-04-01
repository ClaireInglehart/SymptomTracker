//
//  SignUpViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//
import LocalAuthentication
import UIKit
import CryptoKit
import CommonCrypto

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        
        self.continueButton.layer.cornerRadius = 8.0
    
    }
    
    

    @IBAction func touchID(_ sender: UIButton) {
            let context = LAContext()
            var error: NSError? = nil
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                    let reason = "Please evaluate with touch id"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                    DispatchQueue.main.async {
                        
                        guard success, error == nil else {
                            //failed
                            
                                //cannot evaluate faceid
                                let alert = UIAlertController(title: "Failed to Authenticate",
                                message: "Please try again",
                                                              preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Dismiss",
                                                              style: .cancel, handler: nil))
                            self?.present(alert, animated: true)
                            return
                        }
        
                        self?.performSegue(withIdentifier: "ShowWelcome", sender: sender)
                    }
                }
            }
        
        else {
            //cannot evaluate faceid
            let alert = UIAlertController(title: "Unavailable",
            message: "You cant use this feature",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel, handler: nil))
            present(alert, animated: true)
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailField.becomeFirstResponder()
    }
    
    
    @IBAction func onContinue(_ sender: Any) {
        guard let email = emailField.text, email.count > 0 else { return }

        
        guard let password = passwordField.text, password.count > 0 else { return }
//
//        Right now, when you sign up, the password is saved along with the email address. Then when you’re logging in, the app compares the email and password that are entered with the email and password that are stored.
//        Instead, when signing up, the hash of the password (along with the email) should be saved. Then when signing in, get a hash of the password the user enters and compare that (and the email) to the stored hash. Does that make sense?
        // Make sure an account with this email doesn't already exist
        
        func sha256(str: String) -> String {
         
            if let strData = str.data(using: String.Encoding.utf8) {
                /// #define CC_SHA256_DIGEST_LENGTH     32
                /// Creates an array of unsigned 8 bit integers that contains 32 zeros
                var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
         
                /// CC_SHA256 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
                /// Takes the strData referenced value (const unsigned char *d) and hashes it into a reference to the digest parameter.
                strData.withUnsafeBytes {
                    // CommonCrypto
                    // extern unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)  -|
                    // OpenSSL                                                                             |
                    // unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)        <-|
                    CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
                }
         
                var sha256String = ""
                /// Unpack each byte in the digest array and add them to the sha256String
                for byte in digest {
                    sha256String += String(format:"%02x", UInt8(byte))
                }
         
                if sha256String.uppercased() == "E8721A6EBEA3B23768D943D075035C7819662B581E487456FDB1A7129C769188" {
                    print("Matching sha256 hash: E8721A6EBEA3B23768D943D075035C7819662B581E487456FDB1A7129C769188")
                } else {
                    print("sha256 hash does not match: \(sha256String)")
                }
                return sha256String
            }
            return ""
        }

        let sha256Str = sha256(str: password)

        
        if let _ = DataService.shared.getUser(forEmail: email, forPassword: sha256Str) {
            let title = "Account Already Exists"
            let message = "An account with this email address already exists. Please sign in."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)

        } else {
        
            if let newUser = DataService.shared.addUser(withEmail: email, withPassword: sha256Str) {
                DataService.shared.currentUser = newUser
                performSegue(withIdentifier: "ShowWelcome", sender: sender)
            } else {
                let title = "Account Error"
                let message = "An error occurred. Please try again."
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.emailField) {
            if let email = textField.text, email.count > 0 {
                self.passwordField.becomeFirstResponder()
                return true
            }
        } else if (textField == self.passwordField) {
            if let email = textField.text, email.count > 0,
               let password = textField.text, password.count > 0 {
                }
                self.onContinue(textField)
                return true
            }
        return false
        }
    }
