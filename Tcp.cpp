#include "Tcp.h"
#include "ui_Tcp.h"
#include "configdata.h"

#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonArray>
#include <QPushButton>
#include <QUrl>
#include <qfiledialog.h>
#include <QProcess>
#include <QTimer>
#include <QDebug>
#include <iostream>
#include <QBuffer>
#include <QtQuick>
#include <QQuickView>
#include <QQmlApplicationEngine>
Tcp::Tcp(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Tcp)
{   
    QQuickWindow::setGraphicsApi(QSGRendererInterface::GraphicsApi::OpenGL);
    setFocusPolicy(Qt::StrongFocus);
    ui->setupUi(this);
    setWindowTitle("MRStage-QT");
//    CodeImage = new ShowImage(this);
//    QQuickView view;
//    QQmlApplicationEngine engine=view.engine();
//    ShowImage *CodeImage = new ShowImage(this);
//    engine.rootContext()->setContextProperty("CodeImage",CodeImage);
//    engine.addImageProvider(QLatin1String("CodeImg"), CodeImage->m_pImgProvider);

    server = nullptr;
    serverThread = nullptr;
    msgDisplayTimer= new QTimer(this);
    test1Timer = new QTimer(this);
//    test2Timer = new QTimer(this);

    ui->quickWidget->setSource(QUrl("qrc:/qml/qml/MainPanelForm.qml"));
    ui->quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView );
    item=ui->quickWidget->rootObject();
    //widget的slot connect qml的signal
    connect(item,SIGNAL(sendCameraMsgQml(QString,QString)),this,SLOT(SendCameraMsg(QString,QString)));
    connect(item,SIGNAL(openScreenFileQml(QString,QString)),this,SLOT(OpenScreenFile(QString,QString)));
    connect(item,SIGNAL(sendItemMsgQml(QString)),this,SLOT(SendItemMsg(QString)));
    connect(item,SIGNAL(sendSwitchAutoMotionMsgQml(bool)),this,SLOT(SendAutoMotionMsg(bool)));
    connect(item,SIGNAL(sendSwitchAutoMotionMusicMsgQml(bool)),this,SLOT(SendAutoMusicMsg(bool)));
    connect(item,SIGNAL(sendSwitchAutoMotionImageEffectsMsgQml(bool)),this,SLOT(SendAutoImageEffectsMsg(bool)));
    connect(item,SIGNAL(sendFwMsgQml(QString)),this,SLOT(SendAutoFwBtnMsg(QString)));
    connect(item,SIGNAL(sendSliderVlue(int)),this,SLOT(sendSliderValue(int)));
    connect(item,SIGNAL(sendScenceMsgQml(QString)),this,SLOT(sendScenceMsg(QString)));
//    m_SpoutReceiver.SetReceiverName("MRstageCamera");
//    test2Timer = new QTimer(this);
//    test2Timer->start(500);
////    connect(test2Timer,SIGNAL(timeout()),this,SLOT(getImageData()));
//    qmlRegisterType<PaintItem>("PaintItemModule",1,0,"PaintItem");
//    connect(test2Timer,SIGNAL(timeout()),this,SLOT(SendPaintItem()));
//    connect(item,SIGNAL(timeoverImage()),this,SLOT(SendPaintItem()));
//    int a =75;
//    QMetaObject::invokeMethod(item,"_addAutoFSliderWidget",Q_ARG(QVariant,a));
//    QString QSA = "大屏幕";
//    QMetaObject::invokeMethod(item,"_addScrenceWidget",Q_ARG(QVariant,QSA),Q_ARG(QVariant,QCoreApplication::applicationDirPath()));
//    QMetaObject::invokeMethod(item,"_addScrenceWidget",Q_ARG(QVariant,QSA),Q_ARG(QVariant,QCoreApplication::applicationDirPath()));

    CreateServer();
}

Tcp::~Tcp()
{
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","Close");
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);

    delete ui;

    if(serverThread)
    {
        serverThread->quit();
        serverThread->wait();
        delete serverThread;
    }
    serverThread = nullptr;

    if(server)
        delete server;
    server = nullptr;
}

void Tcp::CreateServer()
{
    if(!server)
    {
        server = new Server("QTServer",QWebSocketServer::SslMode::NonSecureMode);
        serverThread = new QThread;
        server->moveToThread(serverThread);
        serverThread->start();

        connect(this,&Tcp::serverMsg,server,&Server::send);
        connect(server,SIGNAL(msg(QString)),this,SLOT(HandleMsg(QString)));
        connect(server,SIGNAL(DisplayErrorMsg(QString)),this,SLOT(DisplayErrorMsg(QString)));
    }
}

void Tcp::HandleMsg(const QString &str)
{
    qDebug()<<"receive:"<<str;
    if(str=="heartbeat")
    {
        emit serverMsg("heartbeat");
        return;
    }
    QJsonDocument jsonDocument = QJsonDocument::fromJson(str.toUtf8().data());
    if(!jsonDocument.isNull())
    {
        QJsonObject jsonObject =jsonDocument.object();
        QString funcName=jsonObject.value("FuncName").toString();
        if(funcName=="AllInteractionInfMsg")
            HandleAllInteractionInfMsg(jsonObject);
        else if(funcName=="ErrorMsg")
            HandleErrorMsg(jsonObject);
        else if(funcName=="SwitchCamera")
            HandleSwitchCameraMsg(jsonObject);
        else if(funcName=="SwitchAutoMotion")
            HandleAutoMotionMsg(jsonObject);
    }
    else
    {
        DisplayErrorMsg("信息接收失败");
        return;
    }
}

void Tcp::HandleAllInteractionInfMsg(QJsonObject jsonObject)
{

    QJsonArray data = jsonObject.value("Msg").toArray();
    mapName=jsonObject.value("MapName").toString();
    QMetaObject::invokeMethod(item,"_clearWidget");
    QMetaObject::invokeMethod(item,"_clearSecnecWidget");
    scenceList.clear();


    cameraMap.clear();
    for (qint32 i=0;i< data.size();i++ ) {
        QString name=data[i].toObject().value("Name").toString();
        QString category=data[i].toObject().value("Category").toString();
        if(category=="Item"||category=="Effects")
        {
            QMetaObject::invokeMethod(item,"_addItemWidget",Q_ARG(QVariant,name),Q_ARG(QVariant,QCoreApplication::applicationDirPath()));
            itemList.append(name);
        }
        //恒进
        else if(category=="Camera")
        {
            QJsonObject otherInfo=data[i].toObject().value("OtherInfo").toObject();
            QJsonArray motionArray=otherInfo.value("otherInfo").toArray();
            QStringList motion;
            for(int i=0;i<motionArray.size();i++)
            {

                motion.append(motionArray[i].toString());

            }
            cameraMap.insert(name,motion);
        }
        else if(category=="Screen"||category=="Poster")
        {
            QMetaObject::invokeMethod(item,"_addScreenWidget",Q_ARG(QVariant,name),Q_ARG(QVariant,category));
        }
        else if(category=="Atmosphere")
        {
            QMetaObject::invokeMethod(item,"_addAutoFwbuttonWidget",Q_ARG(QVariant,name));
        }
/////////////////////////////////////////////////////////////////////////////////////
        else if(category == "LevelManager")
        {
            QJsonObject otherInfo=data[i].toObject().value("OtherInfo").toObject();

            QJsonArray motionArray=otherInfo.value("otherinfo").toArray();
            for(int i=0;i<motionArray.size();i++)
            {
                std::cout << motionArray.size() <<std::endl;
                scenceList.append(motionArray[i].toString());
            }
        }
//        else if(category=="WindowsAudio")
//        {
//            QMetaObject::invokeMethod(item,"_addAutoFSliderWidget",Q_ARG(QVariant,));
//        }
    }
    if(cameraMap.size()>0)
    {
        QStringList cameraList;
        cameraList= cameraMap.keys();
        QString activeCamera=cameraList.at(0);
        QMetaObject::invokeMethod(item,"_addCameraWidget",Q_ARG(QVariant,cameraList),Q_ARG(QVariant,cameraMap.find(activeCamera).value()),Q_ARG(QVariant,mapName),Q_ARG(QVariant,QCoreApplication::applicationDirPath()));
    }
    if(scenceList.size()>0)
    {
        for(int i=0;i<scenceList.size();i++)
        {
            std::cout << scenceList.at(i).data() <<std::endl;
        }
        QMetaObject::invokeMethod(item,"_addScrenceWidget",Q_ARG(QVariant,scenceList),Q_ARG(QVariant,QCoreApplication::applicationDirPath()));
    }

    QMetaObject::invokeMethod(item,"_SendScenMsg");
    QMetaObject::invokeMethod(item,"_addAutoMotionWidget");
    QMetaObject::invokeMethod(item,"_addAutoMotionMusicWidget");
    QMetaObject::invokeMethod(item,"_addAutoMotionImageEffectsWidget");
}

void Tcp::HandleErrorMsg(QJsonObject jsonObject)
{
    QJsonObject msg=jsonObject.value("Msg").toObject();
    QString errorMsg= msg.value("Msg").toString();
    qDebug()<<errorMsg;
    item->setProperty("errorMsg","ERROR:"+errorMsg);
    msgDisplayTimer->stop();
    connect(msgDisplayTimer, &QTimer::timeout,[&](){item->setProperty("errorMsg","");});
    msgDisplayTimer->start(5000);
}
//刷新
void Tcp::HandleSwitchCameraMsg(QJsonObject jsonObject)
{
    QJsonObject msg=jsonObject.value("Msg").toObject();
    QString camera= msg.value("CameraName").toString();
    QMetaObject::invokeMethod(item,"_refreshCameraWidget",Q_ARG(QVariant,camera),Q_ARG(QVariant,cameraMap.find(camera).value()));
}
void Tcp::HanderfrshSencewidget(QJsonObject jsonObject)
{

}

void Tcp::HandleAutoMotionMsg(QJsonObject jsonObject)
{
    QJsonObject msg=jsonObject.value("Msg").toObject();
    bool state= msg.value("State").toBool();
    QMetaObject::invokeMethod(item,"_setAutoMotionState",Q_ARG(QVariant,state));
}


void Tcp::DisplayErrorMsg(QString msg)
{
    item->setProperty("errorMsg","ERROR:"+msg);
    qDebug()<<msg;
    msgDisplayTimer->stop();
    connect(msgDisplayTimer, &QTimer::timeout,[&](){item->setProperty("errorMsg","");});
    msgDisplayTimer->start(5000);
}

void Tcp::keyPressEvent(QKeyEvent  *event)
{
    if(event->key()==Qt::Key_Q)
    {
        if(!server->IsConnect())
        {
            DisplayErrorMsg("通信未连接");
            return;
        }
        QJsonObject jsonObject;
        jsonObject.insert("FuncName","AllInteractionInfMsg");
        QString msg=QString(QJsonDocument(jsonObject).toJson());
        emit serverMsg(msg);
    }
    else if(event->key()==Qt::Key_F5)
    {
        if(!test1Timer->isActive())
        {
            connect(test1Timer, SIGNAL(timeout()), server, SLOT(test1()));
            test1Timer->start(5*60*60*1000);
        }
        else
        {
            test1Timer->stop();
            test1Timer=nullptr;
        }
    }
//    else if(event->key()==Qt::Key_F6)
//    {
//        if(!test2Timer->isActive())
//        {
//            connect(test2Timer, SIGNAL(timeout()), this, SLOT(test2()));
//            test2Timer->start(30000);
//        }
//        else
//        {
//            test2Timer->stop();
//            test2Timer=nullptr;
//        }
//    }
}
//机位控制衡中 远近  前后 抖动什么的
void Tcp::SendCameraMsg(const QString &camera,const QString &motion)
{
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","InteractionEvent");
    if(motion.size()>0)
    {
        jsonObject.insert("Name",camera);
        jsonObject.insert("Motion",motion);
    }
    else
    {
        jsonObject.insert("Name","CameraManager");
        jsonObject.insert("CameraName",camera);
    }
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    //QMetaObject::invokeMethod(item,"_refreshCameraWidget",Q_ARG(QVariant,camera),Q_ARG(QVariant,cameraMap.find(camera).value()));
    emit serverMsg(msg);
}
//打开文件加
void Tcp::OpenScreenFile(const QString &screen,const QString &type)
{
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QString Url="";
    if(type=="Screen")
        Url = QFileDialog::getOpenFileName(this,tr(""),"~/",tr("MP4 Files(*.mp4)"));
    else if(type=="Poster")
        Url = QFileDialog::getOpenFileName(this,tr(""),"~/",tr("PNG/JPG Files(*.png *.jpg)"));
    if(Url.length()>0)
    {
        QJsonObject jsonObject;
        jsonObject.insert("FuncName","InteractionEvent");
        jsonObject.insert("Name",screen);
        jsonObject.insert("Url",Url);
        QString msg=QString(QJsonDocument(jsonObject).toJson());
        emit serverMsg(msg);
    }

}
//道具互动 使用按钮发送
void Tcp::SendItemMsg(const QString &item)
{
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","InteractionEvent");
    jsonObject.insert("Name",item);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}

void Tcp::SendAutoMotionMsg(bool state)
{
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","InteractionEvent");
    jsonObject.insert("Name","自动运镜");
    jsonObject.insert("SwitchState",state);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}
void Tcp::SendAutoMusicMsg(bool state)
{
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","InteractionEvent");
    jsonObject.insert("Name","音乐运镜");
    jsonObject.insert("SwitchState",state);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}
void Tcp::SendAutoImageEffectsMsg(bool state)
{
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","InteractionEvent");
    jsonObject.insert("Name","镜像特效");
    jsonObject.insert("SwitchState",state);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}
//氛围切换 按钮发送数据
void Tcp::SendAutoFwBtnMsg(QString name)
{
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","InteractionEvent");
    jsonObject.insert("Name",name);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}
static qint32 cameraindex=0;
static qint32 motionindex=0;
void Tcp::test2()
{
    if(cameraMap.size()>0)
    {
        QList<QString> keys=cameraMap.keys();
        QStringList motions=cameraMap.find(keys[cameraindex]).value();
        SendCameraMsg(keys[cameraindex],motions[motionindex]);
        if(motions.size()==motionindex+1)
        {
            motionindex=0;
            if(keys.size()==cameraindex+1)
                cameraindex=0;
            else
                cameraindex++;
        }
        else
            motionindex++;
    }
    if(itemList.size()>0)
    {
        for(int i=0;i<itemList.size();i++)
        SendItemMsg(itemList[i]);

    }
}

void Tcp::getImageData()
{
//    m_SpoutReceiver.SetReceiverName("MRstageCamera");
//      m_SpoutReceiver.SetReceiverName("Camera_Horizontal1");
//    m_SpoutReceiver.SetReceiverName("Sender");
//    if(m_SpoutReceiver.GetSenderFps())
//    {
//        //帧率
//        std::cout<<m_SpoutReceiver.GetSenderFps()<<std::endl;
//        std::cout <<m_SpoutReceiver.GetSenderName()<<std::endl;
//    }
//    std::cout<<"==1111=="<<std::endl;


//    if (m_SpoutReceiver.ReceiveTexture(m_SpoutTexID, GL_TEXTURE_2D, true))
//    {
//        std::cout<<"==22222=="<<std::endl;
//       // IsUpdated() returns true if the sender has changed
//       if (m_SpoutReceiver.IsUpdated())
//       {
//           // Update globals
//           std::cout<<"==3333=="<<std::endl;
//           g_SenderWidth = m_SpoutReceiver.GetSenderWidth();
//           g_SenderHeight = m_SpoutReceiver.GetSenderHeight();
//           g_SenderFormat = m_SpoutReceiver.GetSenderFormat();

//           glGenTextures(1, &m_SpoutTexID);
//           glBindTexture(GL_TEXTURE_2D, m_SpoutTexID);
//           glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, g_SenderWidth, g_SenderHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, nullptr);
//           glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//           glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
//       }

//    }
//    if(m_SpoutTexID)
//    {
//        std::cout<<"==44444=="<<m_SpoutTexID<<std::endl;
//        QMetaObject::invokeMethod(item,"_refreshSpoutTextureData",Q_ARG(QVariant,m_SpoutReceiver.GetSenderName()),Q_ARG(QVariant,m_SpoutTexID));
//    }
//    if (m_SpoutReceiver.ReceiveImage(pixelBuffer, GL_RGBA, false))
//    {
////       IsUpdated() returns true if the sender has changed
//       if (m_SpoutReceiver.IsUpdated())
//       {
////           Update globals
//           g_SenderWidth = m_SpoutReceiver.GetSenderWidth();
//           g_SenderHeight = m_SpoutReceiver.GetSenderHeight();
//           g_SenderFormat = m_SpoutReceiver.GetSenderFormat();
//           if (pixelBuffer)
//           {
//               free(pixelBuffer);
//           }

//           pixelBuffer = static_cast<unsigned char*>(malloc(g_SenderWidth * g_SenderHeight * 4));
//       }
//    }
//    if(pixelBuffer)
//    {
//        QImage img(pixelBuffer,g_SenderWidth,g_SenderHeight,QImage::Format_ARGB32);
////        if(img.save("C:/pixelBuffer.jpg","JPEG"))
//            ui->label->setPixmap(QPixmap::fromImage(img.scaled(ui->label->width(),ui->label->height(),Qt::KeepAspectRatio)));
//        QMetaObject::invokeMethod(item,"_refreshImageData",Q_ARG(QVariant,m_SpoutReceiver.GetSenderName()),Q_ARG(QVariant,*pixelBuffer));

//    }
}
void Tcp::SendPaintItem(){
    std::cout <<"22222222"<<std::endl;
}
void Tcp::SendSlideMusic(double a)
{
    if(!server->IsConnect())q
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("MusicVolume",a);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}
//滑块
void Tcp::sendSliderValue(int value)
{
//    std::cout <<value<<std::endl;
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;

    jsonObject.insert("FuncName","InteractionEvent");
    jsonObject.insert("Name","WindowsAudioValueManager");
    jsonObject.insert("AudioValue",value);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}
//场景切换
void Tcp::sendScenceMsg(QString name)
{
    std::cout <<" name "<<std::endl;
    if(!server->IsConnect())
    {
        DisplayErrorMsg("通信未连接");
        return;
    }
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","InteractionEvent");
    jsonObject.insert("Name","LevelManager");
    jsonObject.insert("LevelName",name);
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    emit serverMsg(msg);
}
