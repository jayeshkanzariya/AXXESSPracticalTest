//
//  NetworkService.swift
//
import Foundation
import Moya
import Alamofire
import UIKit


/// Singleton class that is used to handle stuff related to the network service.
final class NetworkService {
    /// It's used to access the instance of `NetworkService`.
    static let shared: NetworkService = NetworkService()
    /// It's used to access the instance of `NetworkReachabilityManager`.
    private let reachabilityManager = Alamofire.NetworkReachabilityManager()
    /// It's used to store the instance of `DataProvider`.
    var dataProvider = MoyaProvider<DataProvider>()
    /// It's used to initialise the basic setup for network services.

    private init() {
        configureNetworkReachability()
    }
    /// It's used to configure the network reachability.
    func configureNetworkReachability() {
        reachabilityManager?.startListening(onUpdatePerforming: { (status) in
            switch status {
                case .notReachable:
                    print("Internet is NOT WORKING")
                case .reachable(let connectionType):
                    print(connectionType)
                    print("Internet is available")
                case .unknown:
                    print("Unknown State")
            }
        })
    }
    
    
    /// it's used to get requested model from the server.
    ///  - Parameters:
    ///     - provider: that is for moya provider.
    ///     - type: that is for moya target type.
    ///     - success: closure that is used to capture the success data model.
    ///     - failure: closure the is used to capture the failure model that is instance of AppError.
    
    func callService<T: Codable, TT:TargetType, P: MoyaProvider<TT>>(_ provider:P, type:TT, success: @escaping ((T) -> Void), failure: @escaping ((String) -> Void)){
        if (reachabilityManager?.isReachable)! {
            provider.request(type) { (result) in
                switch result {
                    case let .success(response):
                        do {
                            let _ = try response.filterSuccessfulStatusCodes()
                            let modelObj : T = try response.data.decodeData()
                            success(modelObj)
                        } catch(let error) {
                            failure(error.localizedDescription)
                        }
                    case let .failure(error):
                        failure(error.localizedDescription)
                }
            }
        }
    }
    /// It's used to idetify internet is working or not.
    ///  - Returns:
    ///     - returns bool object that is used to identify internet is working or not.
    func internetIsWorking() -> Bool {
        return NetworkService.shared.reachabilityManager?.isReachable ?? false
    }
}
/// Custom alamofire manager class that is used to customise the alamofile session manager.
class DefaultAlamofireManager: Alamofire.Session {
    /// lazy instance of `DefaultAlamofireManager`.
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 60 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
