//
//  ValidationsUtils.swift
//  ExpressPackageTracker
//
//  Created by MOON on 2023/06/04.
//

import Foundation

class ValidationsUtils {
    func validateTrackerId(
        expressCompany:ExpressCompany,
        id:String
    ) -> Bool{
        
        var isRegexExpressIncorrect = false
        
        switch expressCompany {
          case .PostJapan:
              let domesticPattern = "[0-9]{11}"
              let internationalPattern = "[A-Z]{2}[0-9]{9}JP"
              var domesticPatternResult:[String] = []
              var internationalPatternResult:[String] = []
              isRegexExpressIncorrect = !(id.pregMatche(pattern: domesticPattern, matches: &domesticPatternResult) || id.pregMatche(pattern: internationalPattern, matches: &internationalPatternResult))
          case .Yamato:
              let yamatoPattern1 = "[0-9]{11}"
              let yamatoPattern2 = "[0-9]{12}"
              var yamatoPattern1Result:[String] = []
              var yamatoPattern2Result:[String] = []
              isRegexExpressIncorrect = !(id.pregMatche(pattern: yamatoPattern1, matches: &yamatoPattern1Result) || id.pregMatche(pattern: yamatoPattern2, matches: &yamatoPattern2Result))
          case .Sagawa:
              let sagawaPattern = "[0-9]{12}"
              var sagawaPatternResult:[String] = []
              isRegexExpressIncorrect = !id.pregMatche(pattern: sagawaPattern, matches: &sagawaPatternResult)
          }
          
          return isRegexExpressIncorrect
    }
}
