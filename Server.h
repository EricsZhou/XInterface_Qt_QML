#ifndef SERVER_H
#define SERVER_H

#include <QObject>

#include <QWebSocket>
#include <QWebSocketServer>

#include <QThread>

#include <QDebug>

class Server : public QWebSocketServer
{
    Q_OBJECT

public:
    Server(const QString &serverName, SslMode secureMode,
           QObject *parent = nullptr);
    bool IsConnect();
signals:
    void msg(const QString &);
    void DisplayErrorMsg(QString msg);

public slots:
    void send(const QString &);
    void NewConnection();
    void ReadyRead(const QString &message);
    void AcceptError(QAbstractSocket::SocketError error);
    void Disconnected();

    void test1();
private:
    QWebSocket *socket;

    QByteArray receiveData;
    qint32 totalLength = 0;
    qint32 stringLength = 0;
    bool bHasLength = false;


    //QTimer *timer;
};

#endif // SERVER_H
