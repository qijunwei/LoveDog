//
//  FMDBDataManager.swift
//  LoveDog
//
//  Created by wei on 16/9/5.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import FMDB

class FMDBDataManager: NSObject {
    
    //单例对象
    static let defaultManger = FMDBDataManager()
    
    //用来操作数据库的
    let fmdb: FMDatabase
    
    override init() {
        
        //拼接出数据库的路径
        let path = NSHomeDirectory().stringByAppendingString("/Documents/wqjLike.db")
        
        //使用路径构造数据库管理者
        fmdb = FMDatabase.init(path: path)
        
        //如果对应的数据库不存在，就先创建再打开
        //如果对应的数据库已经存在，就直接打开
        if !fmdb.open() {
            print("open error")
            return
        }
        
        let createSql = "create table if not exists likeInfo(id varchar(256) primary key, name varchar(256))"
        
        //执行sql并且进行错误处理
        do {
            try fmdb.executeUpdate(createSql, values: nil)
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }
    
    func insertWith(model: DogModel) -> Void {
        //插入数据的sql语句(参数需要以通配符的形式设置)
        let insertSql = "insert into likeInfo(id, name) values(?, ?)"
        do {
            try fmdb.executeUpdate(insertSql, values: [model.id!, model.name!])
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }
    
    func updateWith(model: DogModel, uid: String) -> Void {
        //修改某个id的数据
        let updateSql = "update likeInfo set id = ?, name = ? where id = ?"
        do {
            try fmdb.executeUpdate(updateSql, values: [model.id!, model.name!, uid])
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }
    
    func selectAll() -> [DogModel] {
        var tmpArr = [DogModel]()
        //查询所有数据
        let selectSql = "select * from likeInfo"
        do {
            let rs = try fmdb.executeQuery(selectSql, values: nil)
            while rs.next() {
                //在这个循环内部，rs会分别代表所有的查询结果
                let model = DogModel()
                model.id = rs.stringForColumn("id")
                model.name = rs.stringForColumn("name")
                tmpArr.append(model)
            }
        } catch {
            print(fmdb.lastErrorMessage())
        }
        return tmpArr
    }

    //删除数据
    func deleteSql(model: DogModel, uid: String){
        let deleteSql = "delete from likeInfo where id = ?"
        do{
            try fmdb.executeUpdate(deleteSql, values: [uid])
        }catch{
            print(fmdb.lastErrorMessage())
        }

    }
    
    
}

