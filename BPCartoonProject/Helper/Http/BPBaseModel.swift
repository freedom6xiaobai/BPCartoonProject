//
//  BPBaseModel.swift
//  BPCartoonProject
//
//  Created by baipeng on 2019/7/9.
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




///MAARK: 发现列表 返回data数据转化
struct FindDataModel : HandyJSON {
    var defaultSearch:String?
    var editTime: TimeInterval = 0
    var floatItems : LocalInfoButtonModel?
    var galleryItems:[GalleryItemModel]?
    var modules:[ModulesModel]?
    var textItems:[String]?
}

struct LocalInfoButtonModel : HandyJSON {
    var localInfoButton:Bool?
}
//轮播图
struct GalleryItemModel : HandyJSON {
    var id: Int = 0
    var linkType: Int = 0
    var cover: String?
    var ext: [ExtModel]?
    var title: String?
    var content: String?
    var topCover:String?
    var over_time:Int = 0
}
struct ExtModel : HandyJSON {
    var key:String?
    var val:Int = 0
}

//类型1
struct ModulesModel : HandyJSON {
    var moduleType:Int = 1
    var uiType:Int = 1
    var moduleInfo:ModuleInfoModel?
    var items:[[ItemsModel]]?
    var item:[ItemsModel]?

    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &item, name: "items")
    }

}
//基本信息
struct ModuleInfoModel :HandyJSON {
    var argValue:Int?
    var argName:String?
    var title:String?
    var icon:String?
    var bgCover:String?
}
//items
struct ItemsModel : HandyJSON {
    var comicId:Int?
    var title:String?
    var cover:String?
    var updateType:Int?
    var subTitle:String?

}

