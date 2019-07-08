//
//  BPHttpClient.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import SVProgressHUD

let ApiProvider = MoyaProvider<UApi>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<UApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

enum UApi {
    case searchHot//搜索热门
    case searchRelative(inputText: String)//相关搜索
    case searchResult(argCon: Int, q: String)//搜索结果

    case todayList(day: Int,page: Int)//今日列表

}

extension UApi: TargetType {
    var baseURL: URL { return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")! }

    var path: String {
        switch self {
        case .searchHot: return "search/hotkeywordsnew"
        case .searchRelative: return "search/relative"
        case .searchResult: return "search/searchResult"

        case .todayList: return "list/todayRecommendList"
        }
    }

    var method: Moya.Method { return .get }
    var task: Task {//任务
        //默认参数
        var parmeters = ["time": Int32(Date().timeIntervalSince1970),
                         "device_id": UIDevice.current.identifierForVendor!.uuidString,
                         "model": UIDevice.current.model,
                         "android_id":"iphone",
                         "target": "U17_3.0",
                         "systemVersion":UIDevice.current.systemVersion,
                         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        switch self { ///拼参数
        case .searchRelative(let inputText):
            parmeters["inputText"] = inputText

        case .searchResult(let argCon, let q):
            parmeters["argCon"] = argCon
            parmeters["q"] = q


        case .todayList(let day, let page):
            parmeters["day"] = day
            parmeters["page"] = max(0, page)

        default: break
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}


/// 返回model -- json转model
extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

///请求
extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {

        return request(target, completion: { (result) in

            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            print("\n",url,"\n",target.task,"\n")

            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData.data?.returnData)
        })
    }
}


//----------------------------------------

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//提示toast
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        SVProgressHUD.show()
    case .ended:
        SVProgressHUD.dismiss()
    }
}

///回调
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<UApi>.RequestResultClosure) -> Void in

    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}
