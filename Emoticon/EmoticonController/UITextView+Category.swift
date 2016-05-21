//
//  UITextView+Category.swift
//  Emoticon
//
//  Created by Imanol on 5/21/16.
//  Copyright © 2016 Imanol. All rights reserved.
//

import UIKit

extension UITextView
{
    func insertEmoticons(emoticon : Emoticon,fontSize : CGFloat){
        //判断当前点击的是否是emoji表情
        if emoticon.emojiStr != nil
        {
            replaceRange(selectedTextRange!, withText: emoticon.emojiStr!)
            
            // 判断当前点击的是否是表情图片
        }else if emoticon.png != nil
        {
            
            let imgText = EmoticonTextAttachment.createImageText(emoticon, fontSize: fontSize)
            //拿到textView content
            let textViewStr = NSMutableAttributedString(attributedString: attributedText)
            //insert emoticon to curse location
            let range = selectedRange
            textViewStr.replaceCharactersInRange(range, withAttributedString: imgText)
            //因为创建的字符串有自己默认的size ，所以需要改变，这里的NSMakeRange(range.location, 1)，之所以是1，是因为上面已经insert了表情进来，这里要改变字体，是因为如果前一个inser了图片，接着insert emoji 表情，如果不改字体大小，emoji表情的大小会不正确
            textViewStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(fontSize), range: NSMakeRange(range.location, 1))
            //替换 textView content
            attributedText = textViewStr
            //恢复光标位置
            // 两个参数: 第一个是指定光标所在的位置, 第二个参数是选中文本的个数
            selectedRange = NSMakeRange(range.location + 1, 0)
        }
        
        //删除按钮
        if emoticon.isDeleteBtn{
            deleteBackward()
        }

    }
}