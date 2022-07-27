#include "qchdbghelp.h"
#include <DbgHelp.h>
#include <QString>
#include <QMessageBox>
#include <QDateTime>
#include <QDir>
//程式异常捕获
LONG ApplicationCrashHandler(EXCEPTION_POINTERS *pException)
{
    //创建 Dump 文件
    QString str =QDateTime::currentDateTime().toString("yyyyMMdd")+ QTime::currentTime().toString("HHmmsszzz") + ".dmp";
    QDir dir;
    if (!dir.exists("./Dump/"))
        bool res = dir.mkpath("./Dump/");
    QString path="./Dump/"+str;
    HANDLE hDumpFile = CreateFile((WCHAR *)(path.utf16()), GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    if( hDumpFile != INVALID_HANDLE_VALUE){
        //Dump信息
        MINIDUMP_EXCEPTION_INFORMATION dumpInfo;
        dumpInfo.ExceptionPointers = pException;
        dumpInfo.ThreadId = GetCurrentThreadId();
        dumpInfo.ClientPointers = TRUE;
        //写入Dump文件内容
        MiniDumpWriteDump(GetCurrentProcess(), GetCurrentProcessId(), hDumpFile, MiniDumpNormal, &dumpInfo, NULL, NULL);
    }
    //这里弹出一个错误对话框并退出程序
    EXCEPTION_RECORD* record = pException->ExceptionRecord;
//    QString errCode(QString::number(record->ExceptionCode,16)),errAdr(QString::number((uint)record->ExceptionAddress,16)),errMod;
//    QMessageBox::critical(NULL,"程式崩溃","<FONT size=4><div><b>对于发生的错误，表示诚挚的歉意</b><br/></div>"+
//                          QString("<div>错误代码：%1</div><div>错误地址：%2</div></FONT>").arg(errCode).arg(errAdr),
//                          QMessageBox::Ok);
    return EXCEPTION_EXECUTE_HANDLER;
}
