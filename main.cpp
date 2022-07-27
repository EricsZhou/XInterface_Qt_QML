#include "Tcp.h"
#include "qchdbghelp.h"
#include <QApplication>
#include <QFile>
#include <QMessageLogContext>
#include <QDebug>
#include <QDateTime>
#include <QMutex>
#include <QDir>
#include <QLoggingCategory>




void outputMessage(QtMsgType type,const QMessageLogContext &context,const QString &msg);
int main(int argc, char *argv[])
{
    QLoggingCategory::setFilterRules("*.info=true\n");
    qInstallMessageHandler(outputMessage);//消息处理函数-日志
    QApplication a(argc, argv);
    SetUnhandledExceptionFilter((LPTOP_LEVEL_EXCEPTION_FILTER)ApplicationCrashHandler);//注冊异常捕获函数
    Tcp w;
    w.show();
    return a.exec();
}

void outputMessage(QtMsgType type,const QMessageLogContext &context,const QString &msg)
{
    static QMutex mutex;
    mutex.lock();
    QByteArray localMsg = msg.toLocal8Bit();
    QString text;
    switch (type)
    {
        case QtDebugMsg:
            text = QString("Debug:");
            break;
        case QtWarningMsg:
            text = QString("Warning:");
            break;
        case QtCriticalMsg:
            text = QString("Critical:");
            break;
        case QtFatalMsg:
            text = QString("Fatal:");
            break;
        default:
            text = QString("Debug:");
    }

    // 设置输出信息格式
       QString context_info = QString("File:(%1) Line:(%2)").arg(QString(context.file)).arg(context.line); // F文件L行数
       QString strDateTime = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
       //QString strMessage = QString("%1 %2 \t%3 \t%4").arg(text).arg(context_info).arg(strDateTime).arg(msg);
       QString strMessage = QString("%1 \t%2 \t%3").arg(text).arg(strDateTime).arg(msg);
       // 输出信息至文件中（读写、追加形式）
       QDir dir;
       if (!dir.exists("./Log/"))
           bool res = dir.mkpath("./Log/");
       QString path="./Log/"+QDateTime::currentDateTime().toString("yyyy-MM-dd").append("-log.txt");
       QFile file(path);
       file.open(QIODevice::ReadWrite | QIODevice::Append);
       QTextStream stream(&file);
       stream << strMessage << "\r\n";
       file.flush();
       file.close();
       // 解锁
        mutex.unlock();
}
