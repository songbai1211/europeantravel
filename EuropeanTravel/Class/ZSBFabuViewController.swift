//
//  ZSBFabuViewController.swift
//  EuropeanTravel
//
//  Created by crespo on 2020/3/13.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit

class ZSBFabuViewController: ZSBBaseViewController,UITextViewDelegate{
    var titleTextView = UITextView()
    var detialTextView = UITextView()
    var picImage:UIImage?
    var infoImageView   = UIImageView()
    var pickController:UIImagePickerController! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "发布文章"
        // Do any additional setup after loading the view.
        
        
        
        view.addSubview(titleTextView)
        titleTextView.delegate = self
        titleTextView.placeholder = "请输入文章标题"
        titleTextView.textAlignment = .center
        titleTextView.font = UIFont.systemFont(ofSize: 14)
//        titleTextView.textColor = UIColor.black
          titleTextView.backgroundColor = UIColor(hexString: "#f5f5f5")
          titleTextView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)?.setOffset(20)
            make?.right.equalTo()(self.view.mas_right)?.setOffset(-20)
              make?.top.equalTo()(self.view.mas_top)?.setOffset(110)
              make?.height.setOffset(40)
          }
        
        view.addSubview(detialTextView)
        detialTextView.delegate = self
        detialTextView.placeholder = "请输入文章内容"
        detialTextView.font = UIFont.systemFont(ofSize: 14)
        detialTextView.backgroundColor = UIColor(hexString: "#f5f5f5")
        detialTextView.mas_makeConstraints { (make) in
          make?.left.equalTo()(self.view)?.setOffset(20)
        make?.right.equalTo()(self.view.mas_right)?.setOffset(-20)
            make?.top.equalTo()(titleTextView.mas_bottom)?.setOffset(15)
            make?.height.setOffset(200)
        }
        
        view.addSubview(infoImageView)
        infoImageView.image = UIImage.init(named: "tianjiatupian")
        infoImageView.contentMode = .scaleAspectFit
        infoImageView.mas_makeConstraints { (make) in
            make?.top.equalTo()(detialTextView.mas_bottom)?.setOffset(20)
            make?.centerX.equalTo()(self.view)
            make?.size.setSizeOffset(CGSize.init(width: 80, height: 80))
        }

        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapView))
        infoImageView.addGestureRecognizer(tap)
        infoImageView.isUserInteractionEnabled = true
        
        
        
        pickController = UIImagePickerController()
        pickController.delegate = self
        
        
        let fabuButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 40))
            //loginButton.b = .UIButtonTypeCustom
            fabuButton.setTitle("点击发布", for: .normal)
            fabuButton.setTitleColor(UIColor.white, for: .normal)
            self.view.addSubview(fabuButton)

        
        let rightItem = UIBarButtonItem.init(customView: fabuButton)
        rightItem.imageInsets = UIEdgeInsets.init(top: 0, left: -15, bottom: 0, right: 0)
        self.navigationItem.rightBarButtonItem = rightItem;
        
        fabuButton.rac_signal(for: .touchUpInside).subscribeNext { (button) in
            
            
            if !ZSBFIleManger.shareInstance().login {
                  let login = ZSBLoginViewController()
                  self.present(login, animated: true, completion: nil)
                return
            }
            
            
            let mb = MBProgressHUD.showAdded(to: self.view, animated: true)
            mb.bezelView.backgroundColor = UIColor(hexString: "#f2394e")
            mb.label.textColor = .white;
            if self.titleTextView.text.count == 0 || self.detialTextView.text.count == 0 {
               mb.label.text = "文章标题和内容不能为空";
               mb.hide(animated: true, afterDelay: 1)
               return;
            }
            
            if self.picImage == nil {
                mb.label.text = "请选择图片";
                mb.hide(animated: true, afterDelay: 1)
                return;
            }
            
            
            self.save()
            
            mb.label.text = "发布成功，等待审核";
            mb.hide(animated: true, afterDelay: 2)
            let delay = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.navigationController?.popViewController(animated: true)

            }
        }
        
    }
    
    func save(){
        let  plistArray = NSMutableArray.init(array: UserDefaults.standard.object(forKey: "wenzhangData") as? Array<Any> ?? [])
        var data = [Any]()
        
        data.append(self.picImage?.jpegData(compressionQuality: 0.5) ?? "")
        data.append(self.titleTextView.text!)
        data.append("")
        data.append(self.detialTextView.text!)
        data.append(Date.init().description)
        plistArray.add(data)
        
        let overArray = NSArray.init(array: plistArray)
        UserDefaults.standard.set(overArray, forKey: "wenzhangData")
        UserDefaults.standard.synchronize()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
   
    
    @objc func tapView() {
    let   controller = UIAlertController.init(title: "请选择需要的操作", message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        // 取消按钮
        controller.addAction(UIAlertAction(title: "拍照选择", style: .default) { action in
            self.openCamera(type: .camera)
            }) // 拍照选择
        controller.addAction(UIAlertAction(title: "相册选择", style: .default) { action in
            self.openCamera(type: .photoLibrary)
        }) // 相册选择
        controller.show(self, sender: nil)
        self.navigationController?.present(controller, animated: true, completion: nil)
        
    }
    
    
    func openCamera(type : UIImagePickerController.SourceType) {
        pickController.sourceType = type
        self.present(pickController, animated: true, completion: nil)
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

extension ZSBFabuViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.infoImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        self.infoImageView.contentMode = .scaleToFill // 缩放显示, 便于查看全部的图片
        self.infoImageView.mas_updateConstraints { (make) in
            make?.size.setSizeOffset(CGSize.init(width: SCREEN_WIDTH, height: 200))
        }
         picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
}
