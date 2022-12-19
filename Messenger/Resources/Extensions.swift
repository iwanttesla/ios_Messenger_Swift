//
//  Extensions.swift
//  Messenger
//
//  Created by OCUBE on 2022/12/15.
//

import Foundation
import UIKit

//사이즈를 간편히 쓸수있게 extension한다.
extension UIView{
    
    public var width:CGFloat{
        return self.frame.size.width
    }
    
    public var height:CGFloat{
        return self.frame.size.height
    }
    
    public var top:CGFloat{
        return self.frame.origin.y
    }
    
    public var bottom:CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left:CGFloat{
        return self.frame.origin.x
    }
    
    public var right:CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}
