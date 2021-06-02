
import Foundation
import Alamofire
import SwiftyJSON

@available(iOS 13.0, *)
class Webservices {
    
    static var session : Alamofire.Session {
        get{
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(240) //4 min
            let sessionManager = Alamofire.Session(configuration: configuration)
            return sessionManager
        }
    }
    
    static var Host : String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    public enum METHODS : String {
        case URL_POST_USERS = "users"
        case URL_POST_POSTS = "posts"
        case URL_POST_POST_BY_USER = "posts?userId="
    }

    static func request(pathMethod : METHODS, pathMethodXtra: String = "", callbackSuccess:@escaping (JSON?)->(), callbackFailure:@escaping (Errors)->()){
        print("// --------------------------------------------------------- ")
        let url = URL(string: Host + pathMethod.rawValue + pathMethodXtra)
        var urlRequest =  URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        print("WS[URL]\n\n================\n\(String(describing: url))\n================\n")
        
        AF.request(urlRequest).responseString(completionHandler: {
            response in
            //print(response)
            let code = response.response?.statusCode
            print(" **** Status Code: \(String(describing: code)) ****")
            if code != 401 {
                switch response.result{
                case .success:
                    print("// --------------------------------------------------------- ")
                    print("endpoint: \(Host + pathMethod.rawValue)")
                    let value =  try! response.result.get()
                    var success: Bool = true
                    var json: JSON = JSON([])
                    (success, json) = String.stringToJson(jsonString: value)
                    if success {
                        print("response:")
                        print(json)
                        print("// --------------------------------------------------------- ")
                        callbackSuccess(json)
                    } else {
                        callbackFailure(.service)
                    }

                case .failure( let error ):
                    print("**************************************************************************************")

                    switch error {
                    case .invalidURL(let url):
                        print("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        print("Parameter encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        print("Multipart encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            print("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable:\(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                        case .customValidationFailed(error: let error):
                            print("Response status code was unacceptable: \(error)")
                        }
                    case .responseSerializationFailed(let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        
                    case .createUploadableFailed(error: let error):
                        print("Failure Reason: \(error)")
                        callbackFailure(.service)
                    case .createURLRequestFailed(error: let error):
                        print("Failure Reason: \(error)")
                        callbackFailure(.url)
                        callbackFailure(.service)
                    case .downloadedFileMoveFailed(error: let error, source: let source, destination: let destination):
                        print("Failure Reason: \(error)\n\(source)\n\(destination)")
                        callbackFailure(.service)
                    case .explicitlyCancelled:
                        print("Failure Reason: \(error)")
                        callbackFailure(.service)
                    case .parameterEncoderFailed(reason: let reason):
                        print("Failure Reason: \(reason)")
                        callbackFailure(.service)
                    case .requestAdaptationFailed(error: let error):
                        print("Failure Reason: \(error)")
                        callbackFailure(.service)
                    case .requestRetryFailed(retryError: let retryError, originalError: let originalError):
                        print("Failure Reason: \(retryError)\n\(originalError)")
                        callbackFailure(.service)
                    case .serverTrustEvaluationFailed(reason: let reason):
                        print("Failure Reason: \(reason)")
                        callbackFailure(.service)
                    case .sessionDeinitialized:
                        print("Failure Reason: \(error)")
                        callbackFailure(.service)
                    case .sessionInvalidated(error: let error):
                        print("Failure Reason: \(String(describing: error))")
                        callbackFailure(.service)
                    case .sessionTaskFailed(error: let error):
                        print("Failure Reason: \(error)")
                        callbackFailure(.url)
                    case .urlRequestValidationFailed(reason: let reason):
                        print("Failure Reason: \(reason)")
                        callbackFailure(.url)
                    }
                    print("Underlying error: \(String(describing: error.underlyingError))")
                    print("**************************************************************************************")
                }
            } else {
                callbackFailure(.unknown)
            }
        })
        
    }
    
    
}
