#include "configdata.h"
#include <QtCore/QtCore>
#include <QDebug>

ConfigData::ConfigData(QString qstrfilename)
{
    if (qstrfilename.isEmpty())
        {
            m_qstrFileName = QCoreApplication::applicationDirPath() + "/Config.ini";
        }
        else
        {
            m_qstrFileName = qstrfilename;
        }

        m_psetting = new QSettings(m_qstrFileName, QSettings::IniFormat);
        qDebug() << m_qstrFileName;
}


ConfigData::~ConfigData()
{
    delete m_psetting;
    m_psetting = 0;
}
void ConfigData::Set(QString qstrnodename,QString qstrkeyname,QVariant qvarvalue)
{
    m_psetting->setValue(QString("/%1/%2").arg(qstrnodename).arg(qstrkeyname), qvarvalue);
}

QVariant ConfigData::Get(QString qstrnodename,QString qstrkeyname)
{
    QVariant qvar = m_psetting->value(QString("/%1/%2").arg(qstrnodename).arg(qstrkeyname));
    return qvar;
}
