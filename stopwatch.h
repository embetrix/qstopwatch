#ifndef STOPWATCH_H
#define STOPWATCH_H
#include <QObject>
#include <QTime>
#include <QTimer>

class Stopwatch : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString minutes READ minutes NOTIFY timeChanged)
    Q_PROPERTY(QString seconds READ seconds NOTIFY timeChanged)
    Q_PROPERTY(QString hundredths READ hundredths NOTIFY timeChanged)
    Q_PROPERTY(QString buttonText READ buttonText NOTIFY buttonTextChanged)
    Q_PROPERTY(bool running READ isRunning NOTIFY runningChanged)

public:
    explicit Stopwatch(QObject *parent = nullptr);
    
    Q_INVOKABLE void startStop();
    Q_INVOKABLE void reset();
    
    QString minutes() const;
    QString seconds() const;
    QString hundredths() const;
    QString buttonText() const;
    bool isRunning() const;

private slots:
    void update();

signals:
    void timeChanged();
    void buttonTextChanged();
    void runningChanged();

private:
    void start();
    void pause();
    void resume();
    void setRunning(bool running);
    qint64 getTime();
    
    bool mRunning;
    qint64 mTotalTime;
    qint64 mTempTime;
    QDateTime mStartTime;
    QTimer *mTimer;
    QString mButtonText;
};

#endif // STOPWATCH_H
