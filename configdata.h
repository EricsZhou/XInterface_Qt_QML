#ifndef CONFIGDATA_H
#define CONFIGDATA_H

#include <QObject>

#include <QVariant>
#include <QSettings>

class ConfigData
{
public:
    ConfigData(QString qstrfilename="");
    virtual ~ConfigData(void);
    void Set(QString,QString,QVariant);
    QVariant Get(QString,QString);
private:
    QString m_qstrFileName;
    QSettings *m_psetting;

};

#endif // CONFIGDATA_H
