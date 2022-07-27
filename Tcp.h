#ifndef TCP_H
#define TCP_H
#include <QWidget>
#include <QtQuickWidgets/QQuickWidget>
#include <QQuickItem>
#include <QPalette>
#include "Server.h"
#include "showimage.h"

#include <QSGNode>
#include <QSGSimpleRectNode>
#include <QSGSimpleTextureNode>
#include <QQuickWindow>
#include <QImage>

namespace Ui {
class Tcp;
}

class Tcp : public QWidget
{
    Q_OBJECT

public:
    explicit Tcp(QWidget *parent = nullptr);
    ~Tcp();
    GLuint m_texID = 0; //纹理Id
    GLuint m_SpoutTexID = 0;

    void keyPressEvent(QKeyEvent  *event); 
    void HandleAllInteractionInfMsg(QJsonObject jsonObject);
    void HandleErrorMsg(QJsonObject jsonObject);
    void HandleSwitchCameraMsg(QJsonObject jsonObject);
    void HandleAutoMotionMsg(QJsonObject jsonObject);

    void HanderfrshSencewidget(QJsonObject jsonObject);
private:
    Ui::Tcp *ui;
    QPalette pal;
    Server *server;
    QThread *serverThread;
    QQuickItem *item;
    QString mapName;
    ShowImage *CodeImage;

    QMap<QString,QStringList> cameraMap;
    QStringList scenceList;
    QList<QString> itemList;
    QList<QString> SencenMsg;
    QTimer* msgDisplayTimer;
    QTimer* test1Timer;
    QTimer* test2Timer;
    int SenderSize = 0;

//    SpoutReceiver m_SpoutReceiver;
//    SpoutReceiver m_SpoutReceiver2;
//    SpoutReceiver m_SpoutReceiver3;
//    unsigned int g_SenderWidth;
//    unsigned int g_SenderHeight;
//    unsigned int g_SenderFormat;
protected slots:
    // server
    void CreateServer();
    void HandleMsg(const QString &str);
    void DisplayErrorMsg(QString msg);
    // qml
    void SendCameraMsg(const QString &camera,const QString &motion);
    void OpenScreenFile(const QString &screen,const QString &type);
    void SendItemMsg(const QString &item);
    void SendAutoMotionMsg(bool state);
    void SendAutoMusicMsg(bool state);
    void SendAutoImageEffectsMsg(bool state);
    void SendAutoFwBtnMsg(QString name);

    void SendSlideMusic(double a);
    //
    void test2();
    void getImageData();

    void SendPaintItem();

    void sendSliderValue(int);
    void sendScenceMsg(QString );
signals:
    // server
    void serverMsg(const QString &);

};

#endif // TCP_H
