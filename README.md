# XDAlert

## 1.有确定按钮
```
        let alert = XDAlert(frame: self.view.bounds)
        alert.delegate = self
        alert.show("从前有座庙，庙里有个老和尚，和小和尚，小和尚，老和尚", confirmBtnTitle: "确定")
```


## 2.无确定按钮
```
        let alert = XDAlert(frame: self.view.bounds)
        alert.delegate = self
        alert.show("从前有座庙，庙里有个老和尚，和小和尚，小和尚，老和尚", confirmBtnTitle: nil)
```

## 3.代理方法
```
    func xdAlertCancelButtonClicked(xdAlert: XDAlert) {
        print("canceled....")
    }
    
    func xdAlertConfirmButtonClicked(xdAlert: XDAlert) {
        print("confrimed....")
    }
```
