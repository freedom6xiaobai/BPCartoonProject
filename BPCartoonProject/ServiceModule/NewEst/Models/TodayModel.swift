//
//  TodayModel.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/8.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import HandyJSON

extension Array: HandyJSON{}

///返回data
struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 1
    var data: ReturnData<T>?
    var msg: String?

}
///返回data 外层转换
struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 1
}

/// - MARK: model 数据中心

///MAARK: 今天列表 返回data数据转化
struct DayDataModel : HandyJSON {
    var comics : [DayItemModel]?
    var curDay:Int?
    var hasMore:Bool?
    var isNew:Bool?
    var page:Int?
}

struct DayItemModel : HandyJSON {
    var todayId:Int = 0
    var btnColor:Int = 0
    var title : String?
    var is_dynamic_img:String?
    var comic_sort:Int = 0
    var publish_time:String?
    var cover : String?
    var actionType:Int = 0
    var uiType: Int = 0
    var comicId: Int = 0
    var comicName :String?
    var author : String?
    var chapterId: Int = 0
    var comicType: Int = 0
    var description: String?
    var chapterIndex: Int = 0
    var tagStr: String?
    var tagColor:String?
    var tagList:[tagItemModel]?
}

struct tagItemModel: HandyJSON {
    var tagStr : String?
    var tagColor : String?
}

