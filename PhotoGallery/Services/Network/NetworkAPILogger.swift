//
//  NetworkAPILogger.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation
import Moya

/// Logs network activity (outgoing requests and incoming responses).
final class NetworkAPILogger: PluginType {
    private let separator = ", "
    private let terminator = "\n"
    private let cURLTerminator = "\\\n"
    private let output: (_ separator: String, _ terminator: String, _ items: Any...) -> Void
    private let requestDataFormatter: ((Data) -> (Data))?
    private let responseDataFormatter: ((Data) -> (Data))?
    
    /// If true, also logs response body data.
    let isVerbose: Bool
    let cURL: Bool
    
    init(verbose: Bool = false,
         cURL: Bool = false,
         output: ((_ separator: String, _ terminator: String, _ items: Any...) -> Void)? = nil,
         requestDataFormatter: ((Data) -> (Data))? = nil,
         responseDataFormatter: ((Data) -> (Data))? = nil) {
        self.cURL = cURL
        self.isVerbose = verbose
        self.output = output ?? NetworkAPILogger.reversedPrint
        self.requestDataFormatter = requestDataFormatter
        self.responseDataFormatter = responseDataFormatter
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        if let request = request as? CustomDebugStringConvertible, cURL {
            output(separator, terminator, request.debugDescription)
            return
        }
        outputItems(logNetworkRequest(request.request as URLRequest?))
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            outputItems(logNetworkResponse(response.response, data: response.data, target: target))
        } else {
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
    }
    
    private func outputItems(_ items: String) {
        output(separator, terminator, items)
    }
}

extension NetworkAPILogger {
    static func JSONResponseDataFormatter(data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data //fallback to original data if it cant be serialized
        }
    }

    static func JSONRequestDataFormatter(data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data //fallback to original data if it cant be serialized
        }
    }
}

private extension NetworkAPILogger {
    func format(identifier: String, message: String) -> String {
        return "\(identifier): \(message) \n"
    }
    
    func logNetworkRequest(_ request: URLRequest?) -> String {
        var output = ""
        
        if let httpMethod = request?.httpMethod {
            output += format(identifier: "HTTP Request Method", message: httpMethod)
        }
        output += format(identifier: "Request", message: request?.description ?? "(invalid request)")
        
        if let headers = request?.allHTTPHeaderFields {
            output += format(identifier: "Request Headers", message: headers.description)
        }
        if let bodyStream = request?.httpBodyStream {
            output += format(identifier: "Request Body Stream", message: bodyStream.description)
        }
        if let body = request?.httpBody, let stringData = String(data: requestDataFormatter?(body) ?? body, encoding: String.Encoding.utf8), isVerbose {
            output += stringData
            output += "\n"
        }
        return output
    }
    
    func logNetworkResponse(_ response: HTTPURLResponse?, data: Data?, target: TargetType) -> String {
        guard let response = response else {
            return format(identifier: "Response", message: "⚠️ Received empty network response for \(target).")
        }
        var output = ""
        if 200..<400 ~= (response.statusCode) {
            output += "✅"
        } else {
            output += "🛑"
        }
        output += format(identifier: "Response", message: "Status Code: \(response.statusCode)  URL:\(response.url?.absoluteString ?? "")")
        
        if let data = data, let stringData = String(data: responseDataFormatter?(data) ?? data, encoding: String.Encoding.utf8), isVerbose {
            output += stringData
            output += "\n"
        }
        return output
    }
}

private extension NetworkAPILogger {
    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            if let string = item as? String {
                Logger.verbose(.networking, string)
            } else {
                Logger.verbose(.networking, String(describing: item))
            }
        }
    }
}
