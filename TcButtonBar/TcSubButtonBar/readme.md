# TcSubButtonBar  
``` php
global  $buttonbar_path     :=  A_ScriptDir "\ButtonBarTest.bar"
global  $sub_buttonbar_path :=  A_ScriptDir "\SubButtonBarTest.bar"
    $Button_empty  := new TcButtonBarButton().empty()
    $Button        := new TcButtonBarButton().cmd( "foo" )
                                             .icon("%systemroot%\system32\shell32.dll", 43)
    $SubButtonBar  := new TcSubButtonBar()
                        .bar(getButtonBar()) ; Link to getNewButtonBar() is below code block
                        .asBar()
                        .backButton($buttonbar_path)
                        .save($sub_buttonbar_path)
}
}
```  