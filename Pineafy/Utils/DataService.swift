import Foundation
import FirebaseDatabase
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    //servicio de informacion
    static let ds = DataService()

    //creamos la referencia a la url
    fileprivate var _REF_BASE = DB_BASE
    fileprivate var _REF_USERS = DB_BASE.child("users")
    fileprivate var _REF_SERVICES = DB_BASE.child("users").child("services")
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    
    var REF_SERVICES:DatabaseReference{
        return _REF_SERVICES
    }
    
    var REF_USERS:DatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String,userData:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userData)

    }
}
