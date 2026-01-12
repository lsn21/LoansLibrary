//
//  Helpers+Mask.swift
//  LoansHelpers
//
//  Created by Siarhei Lukyanau on 31.10.25.
//

import Foundation

extension Helpers {
    
    public class func maskForPhone1(_ count: Int) -> String {
        var mask = "+X XXX-XXX-XXXX"
        switch count {
        case 2:
            mask = "   XXX-XXX-XXXX"
        case 4:
            mask = "    XX-XXX-XXXX"
        case 5:
            mask = "     X-XXX-XXXX"
        case 6:
            mask = "      -XXX-XXXX"
        case 8:
            mask = "        XX-XXXX"
        case 9:
            mask = "         X-XXXX"
        case 10:
            mask = "          -XXXX"
        case 12:
            mask = "            XXX"
        case 13:
            mask = "             XX"
        case 14:
            mask = "              X"
        default:
            mask = ""
        }
        return mask
    }
    
    public class func maskForPhone2(_ count: Int) -> String {
        var mask = "(---) --- ----"
        switch count {
        case 2:
            mask = "  --) --- ----"
        case 3:
            mask = "   -) --- ----"
        case 4:
            mask = "    ) --- ----"
        case 7:
            mask = "       -- ----"
        case 8:
            mask = "        - ----"
        case 9:
            mask = "          ----"
        case 11:
            mask = "           ---"
        case 12:
            mask = "            --"
        case 13:
            mask = "             -"
        default:
            mask = ""
        }
        return mask
    }
    
    public class func maskForPhone3(_ count: Int) -> String {
        var mask = "(xxx) xxx xxxx"
        switch count {
        case 2:
            mask = "  xx) xxx xxxx"
        case 3:
            mask = "   x) xxx xxxx"
        case 4:
            mask = "    ) xxx xxxx"
        case 7:
            mask = "       xx xxxx"
        case 8:
            mask = "        x xxxx"
        case 9:
            mask = "          xxxx"
        case 11:
            mask = "           xxx"
        case 12:
            mask = "            xx"
        case 13:
            mask = "             x"
        default:
            mask = ""
        }
        return mask
    }
    
    public class func maskForPhone4(_ count: Int) -> String {
        var mask = "(XXX) XXX - XX - XX"
        switch count {
        case 2:
            mask = "  XX) XXX - XX - XX"
        case 3:
            mask = "   X) XXX - XX - XX"
        case 4:
            mask = "    ) XXX - XX - XX"
        case 7:
            mask = "       XX - XX - XX"
        case 8:
            mask = "        X - XX - XX"
        case 9:
            mask = "          - XX - XX"
        case 13:
            mask = "             X - XX"
        case 14:
            mask = "               - XX"
        case 18:
            mask = "                  X"
        default:
            mask = ""
        }
        return mask
    }
    
    public class func maskForPhone5(_ count: Int) -> String {
        var mask = "+1 (XXX) XXX-XX-XX"
        switch count {
        case 5:
            mask = "     XX) XXX-XX-XX"
        case 6:
            mask = "      X) XXX-XX-XX"
        case 7:
            mask = "       ) XXX-XX-XX"
        case 10:
            mask = "          XX-XX-XX"
        case 11:
            mask = "           X-XX-XX"
        case 12:
            mask = "            -XX-XX"
        case 14:
            mask = "              X-XX"
        case 15:
            mask = "               -XX"
        case 17:
            mask = "                 X"
        default:
            mask = ""
        }
        return mask
    }

    public class func maskForPhone6(_ count: Int) -> String {
        var mask = "+1(XXX)XXX-XXXX"
        switch count {
        case 4:
            mask = "    XX)XXX-XXXX"
        case 5:
            mask = "     X)XXX-XXXX"
        case 6:
            mask = "      )XXX-XXXX"
        case 8:
            mask = "        XX-XXXX"
        case 9:
            mask = "         X-XXXX"
        case 10:
            mask = "          -XXXX"
        case 12:
            mask = "            XXX"
        case 13:
            mask = "             XX"
        case 14:
            mask = "              X"
        default:
            mask = ""
        }
        return mask
    }

    public class func masckForCodeSms(_ count: Int) -> String {
        var mask = "X   X   X   X   X   X"
        switch count {
        case 1:
            mask = "    X   X   X   X   X"
        case 5:
            mask = "        X   X   X   X"
        case 9:
            mask = "            X   X   X"
        case 13:
            mask = "                X   X"
        case 17:
            mask = "                    X"
        default:
            mask = ""
        }
        return mask
    }
    
    public class func masckForCodeSms2(_ count: Int) -> String {
        var mask = "X-X-X-X-X-X"
        switch count {
        case 1:
            mask = " -X-X-X-X-X"
        case 3:
            mask = "   -X-X-X-X"
        case 5:
            mask = "     -X-X-X"
        case 7:
            mask = "       -X-X"
        case 9:
            mask = "         -X"
        default:
            mask = ""
        }
        return mask
    }

}
