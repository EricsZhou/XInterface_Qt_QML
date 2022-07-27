#include "Server.h"
#include "configdata.h"
#include <QJsonObject>
#include <QJsonDocument>
#include <QByteArray>
#include <QTimer>

Server::Server(const QString &serverName, SslMode secureMode,
               QObject *parent) : QWebSocketServer(serverName,secureMode,parent)
{
    QString host=ConfigData().Get("project","host").toString();
    qint32 port=ConfigData().Get("project","port").toInt();
    listen(QHostAddress(host),port);

    socket=nullptr;

    connect(this,&QWebSocketServer::newConnection,this,&Server::NewConnection);
    //timer=nullptr;
}

void Server::NewConnection()
{
    if(hasPendingConnections())
    {
        socket = nextPendingConnection();
        if(socket)
        {
            connect(socket,&QWebSocket::textMessageReceived,this,&Server::ReadyRead);
            connect(socket,&QWebSocket::disconnected,this,&Server::Disconnected);
            connect(socket,SIGNAL(error(QAbstractSocket::SocketError)),this,SLOT(AcceptError(QAbstractSocket::SocketError)));
        }
    }
}

void Server::ReadyRead(const QString &message)
{
//    qint64 bytes = socket->bytesAvailable();
//    if(bytes>0)
//    {
//        QByteArray data = socket->readAll();
//        receiveData.append(data);
//        totalLength+=bytes;
//        if (!bHasLength && totalLength >= 4)
//        {
//            memcpy(&stringLength, receiveData, 4);
//            bHasLength = true;
//        }
//        if(bHasLength&&(totalLength>=stringLength+4))
//        {
//            QByteArray strBuffer;
//            strBuffer.fill('0',stringLength);
//            memcpy(&(strBuffer.data()[0]),&(receiveData.data()[4]),stringLength);
//            emit msg(strBuffer.toStdString().c_str());

//            totalLength -= stringLength + 4;
    //            receiveData.remove(0, qMin<qint32>(stringLength + 4,receiveData.size()));
    //            bHasLength = false;
    //        }
    //    }
    emit msg(message);
}

void Server::send(const QString &str)
{
//    if(socket!=nullptr)
//    {
//        qint32 len=str.toUtf8().size();
//        socket->write((const char*)(&len),sizeof(len));
//        int state=socket->write(str.toUtf8(),str.toUtf8().size());
//        if(state==-1)
//        {
//            emit DisplayErrorMsg("通信失败");
//            qDebug()<<"SocketState:"<<socket->state();
//        }
//    }
//    else
//        emit DisplayErrorMsg("通信未连接");
    if(socket!=nullptr)
        socket->sendTextMessage(str);
    else
        emit DisplayErrorMsg("通信未连接");
}

void Server::test1()
{
    QJsonObject jsonObject;
    jsonObject.insert("FuncName","AllInteractionInfMsg");
    QString msg=QString(QJsonDocument(jsonObject).toJson());
    send(msg);
    qDebug()<<"test1";
}

bool Server::IsConnect()
{
    if(socket!=nullptr)
    {
        return true;
    }
    return false;
}

void Server::AcceptError(QAbstractSocket::SocketError error)
{
    qDebug()<<"SocketError:"<<error;
}

void Server::Disconnected()
{
    qDebug()<<"Disconnected";
    socket->close();
    socket=nullptr;
    emit DisplayErrorMsg("通信断开");
}
