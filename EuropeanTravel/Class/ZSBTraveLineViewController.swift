//
//  ZSBTraveLineViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/12.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import AAInfographics
class ZSBTraveLineViewController: ZSBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "旅行人数"
        
       let  aaChartView = AAChartView()
        aaChartView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT)
        // set the content height of aachartView
        // aaChartView?.contentHeight = self.view.frame.size.height
        self.view.addSubview(aaChartView)
        
        
        let  aaChartModel = AAChartModel()
            .chartType(.column)//Can be any of the chart types listed under `AAChartType`.
            .title("欧洲各国旅行人数")//The chart title
            .subtitle("每年前往欧洲旅行人数(w)")//The chart subtitle
        .categories(["人数"])
        .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
        .series([
            AASeriesElement()
            .name("英国")
            .data([80]),
            
            AASeriesElement()
                           .name("法国")
                           .data([70]),
            
            AASeriesElement().name("摩洛哥")
                            .data([58]),
            
            AASeriesElement()
                      .name("瑞士")
                      .data([55]),
            
            AASeriesElement()
            .name("芬兰")
            .data([45]),
            
            AASeriesElement()
            .name("丹麦")
            .data([42]),
            
            AASeriesElement()
                .name("德国")
                .data([40]),
            
            AASeriesElement()
                                .name("俄罗斯")
                                .data([39]),
            AASeriesElement()
           .name("冰岛")
           .data([35]),
            AASeriesElement()
                .name("意大利")
                .data([32]),
            AASeriesElement()
                                  .name("乌克兰")
                                  .data([25]),
            AASeriesElement()
                       .name("西班牙")
                       .data([23]),
            
            AASeriesElement()
                       .name("荷兰")
                       .data([22]),
            AASeriesElement()
                    .name("波兰")
                    .data([19]),
            AASeriesElement()
                    .name("保加利亚")
                    .data([17]),
            AASeriesElement()
                                .name("克罗地亚")
                                .data([16]),
            AASeriesElement()
                       .name("比利时")
                       .data([16]),
        AASeriesElement()
                   .name("捷克")
                   .data([14]),
            AASeriesElement()
            .name("梵蒂冈")
            .data([13]),
         AASeriesElement()
         .name("葡萄牙")
         .data([11]),
                      AASeriesElement()
                                 .name("爱尔兰")
                                 .data([6]),
            AASeriesElement()
                                  .name("卢森堡")
                                  .data([6]),
            AASeriesElement()
                       .name("罗马尼亚")
                       .data([3.9]),
        
           
            AASeriesElement()
                       .name("立陶宛")
                       .data([3]),
            
        ])
        aaChartView.aa_drawChartWithChartModel(aaChartModel)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
